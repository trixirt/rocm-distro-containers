#!/bin/sh
# =============================================================================
# Script: test.sh
# Purpose: Install packages and check for file conflicts
#          This script verifies that each installed package provides files
#          that are only provided by the package.
# =============================================================================

# Enable debugging to track execution flow
# set -x

# Update package metadata
dnf update -y -q
dnf makecache -y

# =============================================================================
# Package list for installation
# =============================================================================
PACKAGES="rocm-rpm-macros rocm-rpm-macros-modules"
# PACKAGES="rocm-compilersupport-macros"  # Temporary single-package testing

# =============================================================================
# Loop through each package and install
# =============================================================================
for package in $PACKAGES; do
    echo "Installing package: $package"
    dnf install -q -y $package

    # =============================================================================
    # Conflict Detection Logic
    # For each installed package, strip out files that are build-id cache dirs
    # then check remaining files to see if they're provided by multiple packages
    # =============================================================================
    echo "Checking file conflicts for $package..."
    files=`rpm -ql $package | grep -v build-id`  # grep outputs multiple lines
    
    # Loop through each file the package provides
    for file in $files; do
        # =============================================================================
        # Only process regular files (skip directories)
        # Note: This is a common mistake - globbing $files may also give empty strings
        # =============================================================================
        if [ -f $file ]; then
            
            # =============================================================================
            # For each file, count how many packages provide it.
            # Multiple providers indicate potential conflicts or duplicate content.
            # =============================================================================
            number_matches=`dnf --nogpgcheck provides $file 2>/dev/null | grep 'Filename' | wc -l`
            
            # Only worry about files provided by more than one package
            if [ $number_matches -gt 1 ]; then
                # =============================================================================
                # Capture dnf provides output for detailed analysis
                # Look for the filename to identify all packages that claim to provide it
                # =============================================================================
                dnf -q --nogpgcheck provides $file 2>/dev/null 1> sample.txt
                
                # =============================================================================
                # Expected: PackageName-version : Description
                #          Repo       : repo name
                #          Matched From : 
                #          Filename     : /full/path/to/file
                #
                # Extract lines BEFORE the "Repo" lines (i.e., package name lines),
                # then extract the first field (package name) from those lines
                # =============================================================================
                found_packages=`grep -B 1 'Repo         :' sample.txt | grep -v 'Repo         :' | grep ':' | awk '{ print $1}' | tr '\n' ' '`
                
                problem=0
                likely_problem=
                
                # =============================================================================
                # Analyze each package that provides this file
                # We want to detect if ANY provider does NOT match the expected pattern:
                # The version part should only contain hyphenated version info, not just any suffix
                # =============================================================================
                for f in $found_packages; do
                    version_part=${f#$package}  # Strip the base package name
                    
                    # Check if version_part starts with '-' or is empty (extraction failure)
                    if [[ "${version_part:0:1}" != '-' ]]; then
                        # The string does not start with '-' (or is empty)
                        problem=1
                        likely_problem=${f}
                    fi
                done
                
                if [ $problem == 1 ]; then
                    # =============================================================================
                    # Problem detected: Found a package providing a file that doesn't
                    # match the expected versioning pattern of the current package.
                    # This could indicate:
                    #   - A rogue/unexpected package is claiming to provide the file
                    #   - An older or mismatched version is pulling in conflicting content
                    # =============================================================================
                    echo "Problem with package $package and file $file"         1>> /test.log
                    echo "Likely a conflict with $likely_problem"               1>> /test.log
		    echo "Here is what $package says it conflicts with"         1>> /test.log
		    repoquery --whatconflicts $package                          1>> /test.log
                    echo ""                                                     1>> /test.log
                fi
            fi
        fi
    done
done

# =============================================================================
# Report any conflicts found during the scanning process
# =============================================================================
if [ -f /test.log ]; then
    echo "=========================================="
    echo "Conflict Report:"
    echo "=========================================="
    cat /test.log
fi

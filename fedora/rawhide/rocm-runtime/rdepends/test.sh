#!/bin/bash

# This script analyzes reverse dependencies of rocm-runtime package
# and attempts to install each dependency, verifying installation and uninstallation
# If any step fails, it reports the error and attempts cleanup

# Clean up any existing err.log file
if [ -f err.log ]; then
    rm err.log
fi

# Variable to track failed packages
failed_to_install_packages=""

# Find reverse dependencies using dnf repoquery
# Note: On Fedora, we may need to handle the case where repoquery isn't available
P=$(dnf repoquery --whatrequires rocm-runtime 2>/dev/null || echo "")

# Print each package in the P list and load it
for pkg in $P; do
    echo "Loading package: $pkg"
    
    # Attempt to install the package and capture/output it
    dnf install -y "$pkg" 2>&1
    if [ $? != 0 ]; then
        # Add to failed packages list
        echo "Failed to install package: $pkg" >> err.log
        echo "Installation output:" >> err.log
        dnf install -y "$pkg" 2>&1 >> err.log
        failed_to_install_packages="$failed_to_install_packages $pkg"
    fi
    
    # Remove the package (use dnf remove instead of apt remove)
    dnf remove -y "$pkg" 2>/dev/null || true
    
    # Autoremove (if available)
    dnf autoremove -y 2>/dev/null || true
done

# Print the error log at the end
echo "=== ERROR LOG ==="
cat err.log

# Print failed packages summary
if [ -n "$failed_to_install_packages" ]; then
    echo "=== FAILED TO INSTALL PACKAGES ==="
    echo "$failed_to_install_packages" | tr ' ' '\n' | sort | uniq
fi

echo "Analysis complete."

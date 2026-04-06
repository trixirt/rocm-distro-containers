#!/bin/sh
# This script analyzes reverse dependencies of libhsa-runtime64-1 package
# and attempts to install each dependency, verifying installation and uninstallation
# If any step fails, it reports the error and attempts cleanup

# Clean up any existing err.log file
if [ -f err.log ]; then
    rm err.log
fi

# Variable to track failed packages
failed_to_install_packages=""

P=`apt-rdepends -r libhsa-runtime64-1 | sed -e '/Reverse/d'`

# Print each package in the P list and load it
for pkg in $P; do
    echo "Loading package: $pkg"
    
    # Attempt to install the package and capture/output it
    apt install -y "$pkg"
    if [ $? != 0 ]; then
        # Add to failed packages list
	echo "Failed to install package: $pkg" >> err.log
        echo "Installation output:" >> err.log
        apt install -y "$pkg" 2>&1 >> err.log
        failed_to_install_packages="$failed_to_install_packages $pkg"
    fi
    apt remove --purge -y "$pkg"
    apt autoremove -y
done

# Print the error log at the end
echo "=== ERROR LOG ==="
cat err.log

# Print failed packages summary
if [ -n "$failed_to_install_packages" ]; then
    echo "=== FAILED TO INSTALL PACKAGES ==="
    echo "$failed_to_install_packages" | tr ' ' '\n' | sort | uniq
fi

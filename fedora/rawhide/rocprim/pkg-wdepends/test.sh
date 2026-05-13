#!/bin/bash

# This script analyzes reverse dependencies
PACKAGES="rocprim-devel"

for p in $PACKAGES; do
    echo "Package $p"
    dnf repoquery --whatrequires $p
    echo ""
done

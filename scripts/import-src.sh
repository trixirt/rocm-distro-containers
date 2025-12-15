#!/bin/sh

git branch upstream/latest
gbp import-orig --uscan --pristine-tar --debian-branch=bullwinkle/ubuntu/devel --upstream-version=7.1.0

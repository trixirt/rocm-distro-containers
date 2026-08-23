#!/bin/sh

dnf install -y pip python3-pandas

cd ~/rpmbuild/SOURCES
tar xf rpp-*.tar.gz
rm rpp-*.tar.gz
cd rpp-*

export PATH=/usr/lib64/rocm/llvm/bin:$PATH
export CPLUS_INCLUDE_PATH=/usr/include/rpp
python3 utilities/test_suite/HIP/runMiscTests.py --qa_mode 1 --batch_size 3


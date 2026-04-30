#!/bin/sh

set -x

# libhsakmt                      libhsakmt - HSA Kernel Mode Thunk library for AMD KFD support
pkgconf --list-all | grep libhsakmt || (echo "FAIL: libhsakmt not found." && exit 1)

# -I/usr/lib64/pkgconfig/../../include
pkgconf libhsakmt --cflags | grep include || (echo "FAIL: include not found." && exit 1)
i=`pkgconf libhsakmt --cflags | sed 's/-I//'`

if [ ! -d ${i}/hsakmt ]; then
    echo "FAIL: Epected to find include dir ${i}/hsakmt"
    exit 1
fi

# -L/usr/lib64/pkgconfig/../../lib64 -lhsakmt
pkgconf libhsakmt --libs | grep lhsakmt || (echo "FAIL: -lhsakmt not found." && exit 1)

l=`pkgconf libhsakmt --libs | awk '{ print $1 }' | sed 's/-L//'`
if [ ! -f ${l}/libhsakmt.a ]; then
    echo "FAIL: Epected to find library ${l}/libhsakmt.a"
    exit 1
fi

echo "PASS"
    

#!/bin/sh

cd amdsmi

mkdir build
cd build
cmake -S ${PWD}/.. \
    -DCMAKE_C_COMPILER=gcc \
    -DCMAKE_CXX_COMPILER=g++ \
    -DCMAKE_INSTALL_PREFIX=$PWD

make

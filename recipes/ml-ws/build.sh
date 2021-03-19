#!/bin/bash

cd ml/csrc
./cdef src/cdef.c
cd ../..

pip install -vvv --no-deps --ignore-installed --no-build-isolation --no-binary ':all:' .
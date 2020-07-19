#!/bin/bash

# mixed precision training for pytorch < 1.6
pip install -v --no-cache-dir --global-option="--cpp_ext" --global-option="--cuda_ext" git+https://github.com/NVIDIA/apex.git
pip install -vv --no-deps --ignore-installed --no-build-isolation --no-binary ':all:' .
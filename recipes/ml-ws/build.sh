#!/bin/sh

make kvs3-build kvs3-install kvs3-cffi
pip install -vvv --no-clean --no-deps --ignore-installed --no-build-isolation --no-binary ':all:' .
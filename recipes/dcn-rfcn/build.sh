#!/bin/bash

MXNET_CU101=https://files.pythonhosted.org/packages/54/b1/7d01abca10eef104296d2b3f0c59a7dda7573126d079c9e2609e6c17993b/mxnet_cu101-1.6.0-py2.py3-none-manylinux1_x86_64.whl
pip install $MXNET_CU101 --no-deps --ignore-installed -vv
pip install -vvv --no-deps --ignore-installed --no-build-isolation --no-binary ':all:' .
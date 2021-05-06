#!/bin/bash

MXNET_CU101=https://files.pythonhosted.org/packages/54/b1/7d01abca10eef104296d2b3f0c59a7dda7573126d079c9e2609e6c17993b/mxnet_cu101-1.6.0-py2.py3-none-manylinux1_x86_64.whl
MXNET_CU102=https://files.pythonhosted.org/packages/46/a4/7c81a3ddd2d406bd1e13aa9f2b7a1dc8480eacb7f92a43484d7866ba8b89/mxnet_cu102-1.7.0-py2.py3-none-manylinux2014_x86_64.whl
MXNET_CU102MKL=https://files.pythonhosted.org/packages/47/79/0c0510d5a9a9f3dd018daed4d1e34368b7cb1108c5f889863b4f6bd09740/mxnet_cu102mkl-1.6.0.post0-py2.py3-none-manylinux1_x86_64.whl
MXNET_CU110=https://files.pythonhosted.org/packages/94/9d/deaccef6bac02e3a868ef8de07e4dc8c1c215b810b4bd853bec6964190ba/mxnet_cu110-1.8.0.post0-py2.py3-none-manylinux2014_x86_64.whl
pip install $MXNET_CU110 --no-deps --ignore-installed -vv
pip install -vvv --no-deps --ignore-installed --no-build-isolation --no-binary ':all:' .
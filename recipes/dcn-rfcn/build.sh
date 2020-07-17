#!/bin/bash

MXNET_CU101=https://files.pythonhosted.org/packages/54/b1/7d01abca10eef104296d2b3f0c59a7dda7573126d079c9e2609e6c17993b/mxnet_cu101-1.6.0-py2.py3-none-manylinux1_x86_64.whl
#MXNET_CPU=https://files.pythonhosted.org/packages/45/3f/e84aef209001eb8dba16427855b0dc39f2a58905d7de53a7dd7187059bb2/mxnet_mkl-1.6.0-py2.py3-none-manylinux1_x86_64.whl
#echo CONDA_CPUONLY_FEATURE="$CONDA_CPUONLY_FEATURE"
#if [ -z "$CONDA_CPUONLY_FEATURE"]
#then
    pip install $MXNET_CU101 --no-deps --ignore-installed -vv
#else
#    pip install $MXNET_CPU --no-deps --ignore-installed -vv
#fi
pip install -vvv --no-deps --ignore-installed --no-build-isolation --no-binary ':all:' .
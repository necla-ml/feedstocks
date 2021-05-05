#!/bin/bash

cu_version=cpu
torch_version=torch$PTH_VER
if [ -z "$CONDA_CPUONLY_FEATURE" ]
then
    cu_version=cu$CUDA_PT_VER
fi
CHUMPY=https://files.pythonhosted.org/packages/01/f7/865755c8bdb837841938de622e6c8b5cb6b1c933bde3bd3332f0cd4574f1/chumpy-0.70.tar.gz
XTCOCOTOOLS=https://files.pythonhosted.org/packages/84/93/26a2e38034f5cee86403525118f2cac68bb2aafc4797bcebea0c056611cb/xtcocotools-1.7-cp37-cp37m-manylinux1_x86_64.whl
pip install $CHUMPY $XTCOCOTOOLS -vvv --no-deps --ignore-installed --no-build-isolation
pip install poseval@git+https://github.com/svenkreiss/poseval.git

MMPOSE=https://files.pythonhosted.org/packages/c1/8e/71b5a8214cf1656ab92e0de31b8d0246192a4a7d99c6dbf9264365f15dd9/mmpose-$PKG_VERSION-py2.py3-none-any.whl
pip install $MMPOSE  -vvv --no-deps --ignore-installed --no-build-isolation 
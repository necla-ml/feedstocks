#!/bin/bash

if [ -z "$CONDA_CPUONLY_FEATURE" ]
then
    pip install mmcv-full==$PKG_VERSION+torch1.6.0+cu101 -f https://openmmlab.oss-accelerate.aliyuncs.com/mmcv/dist/index.html
else
    pip install mmcv-full==$PKG_VERSION+torch1.6.0+cpu -f https://openmmlab.oss-accelerate.aliyuncs.com/mmcv/dist/index.html
fi

# MMCV_WITH_OPS=1 pip install -vvv --no-deps --ignore-installed --no-build-isolation --no-binary ':all:' .
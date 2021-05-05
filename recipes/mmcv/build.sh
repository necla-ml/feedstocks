#!/bin/bash

cu_version=cpu
torch_version=torch$PTH_VER
if [ -z "$CONDA_CPUONLY_FEATURE" ]
then
    cu_version=cu$CUDA_PT_VER
fi

pip install mmcv-full==$PKG_VERSION -f https://download.openmmlab.com/mmcv/dist/$cu_version/$torch_version/index.html -vvv --no-deps --ignore-installed --no-build-isolation
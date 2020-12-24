#!/bin/bash

version=0.7.0

git clone --branch v$version https://github.com/pytorch/vision torchvision   # see below for version of torchvision to download
cd torchvision
export BUILD_VERSION=$version  # where 0.x.0 is the torchvision version  
python setup.py install 
#!/bin/bash

KVS_PRODUCER_C=$SRC_DIR
KVS_PIC=$KVS_PRODUCER_C/dependency/libkvspic/kvspic-src
KVS_BUILD=$KVS_PRODUCER_C/build
KVS_BUILD_PIC=$KVS_BUILD/dependency/libkvspic/kvspic-src

# `bad_encoder_fix` merged to deals with non-VCL NALUs ending with a zero byte
# https://github.com/awslabs/amazon-kinesis-video-streams-producer-sdk-cpp/issues/491
# sed -i 's/af2168f7c0334630cbc4a7d02c3171df737a30f8/e0b34ec/' $(KVS_PRODUCER_C)/CMake/Dependencies/libkvspic-CMakeLists.txt

# XXX build static libraries instead
# sed -i 's/cproducer SHARED/cproducer STATIC/' $(KVS_PRODUCER_C)/CMakeLists.txt

mkdir build
cd build
cmake .. -DFIXUP_ANNEX_B_TRAILING_NALU_ZERO=ON -DBUILD_DEPENDENCIES=OFF
make -j6

INCLUDE=$PREFIX/include/com/amazonaws/kinesis/video
LIB=$PREFIX/lib

echo Installing SDK headers at $INCLUDE
for module in common client heap mkvgen state trace utils view; do
    echo Installing $INCLUDE/$module...
    cp -r $KVS_PIC/src/$module/include $PREFIX
done

echo Installing $INCLUDE/cproducer...
cp -r $KVS_PRODUCER_C/src/include $PREFIX

echo Installing libs to $LIB...
mkdir -p $LIB
cp $KVS_BUILD_PIC/*.a $LIB
cp $KVS_BUILD/*.a $LIB
cp $KVS_BUILD/*.so $LIB
#!/usr/bin/env bash
# From docker-llvm-armeabi

set -o errexit

INSTALL_PREFIX=~/Documents/llvm-project/build
BUILD_PREFIX=~/Documents/mina32-newlib/build
TARGET=mina32-elf

mkdir -p build
cd build

export CC_FOR_TARGET=${INSTALL_PREFIX}/bin/clang
export CXX_FOR_TARGET=${INSTALL_PREFIX}/bin/clang++
export AR_FOR_TARGET=${INSTALL_PREFIX}/bin/llvm-ar
export NM_FOR_TARGET=${INSTALL_PREFIX}/bin/llvm-nm
export RANLIB_FOR_TARGET=${INSTALL_PREFIX}/bin/llvm-ranlib
export READELF_FOR_TARGET=${INSTALL_PREFIX}/bin/llvm-readelf
export CFLAGS_FOR_TARGET="-Os -ffreestanding -target ${TARGET} -g"
export AS_FOR_TARGET=${INSTALL_PREFIX}/bin/clang
export LD_FOR_TARGET=${INSTALL_PREFIX}/bin/clang

../configure \
    --host=`cc -dumpmachine` \
    --build=`cc -dumpmachine` \
    --target=${TARGET} \
    --prefix=${BUILD_PREFIX} \
    --disable-newlib-supplied-syscalls \
    --enable-newlib-reent-small \
    --disable-newlib-fvwrite-in-streamio \
    --disable-newlib-fseek-optimization \
    --disable-newlib-wide-orient \
    --enable-newlib-nano-malloc \
    --disable-newlib-unbuf-stream-opt \
    --enable-lite-exit \
    --enable-newlib-global-atexiti \
    --enable-newlib-nano-formatted-io \
    --disable-newlib-fvwrite-in-streamio \
    --disable-nls \
    --disable-newlib-io-float

#    --disable-newlib-nano-formatted-io \
#    --enable-newlib-io-c99-formats \
#    --disable-newlib-io-long-double

make
make install

#!/bin/env bash
set -ex

# folder "build" exists already
mkdir cmake-build
cd cmake-build

BOOST_ROOT=$PREFIX
ZLIB_ROOT=$PREFIX
LIBEVENT_ROOT=$PREFIX

export OPENSSL_ROOT=$PREFIX
export OPENSSL_ROOT_DIR=$PREFIX

cmake -G Ninja \
    ${CMAKE_ARGS} \
    -DCMAKE_INSTALL_PREFIX=$PREFIX \
    -DBUILD_SHARED_LIBS=ON \
    -DBUILD_PYTHON=OFF \
    -DBUILD_HASKELL=OFF \
    -DBUILD_JAVA=OFF \
    -DBUILD_JAVASCRIPT=OFF \
    -DBUILD_NODEJS=OFF \
    -DBUILD_C_GLIB=OFF \
    -DBUILD_TUTORIALS=OFF \
    -DCMAKE_FIND_ROOT_PATH="$PREFIX" \
    -DBUILD_TESTING=OFF \
    -DBoost_INCLUDE_DIRS=${PREFIX}/include \
    ..

# Decrease parallelism a bit as we will otherwise get out-of-memory problems
# This is only necessary on Travis
if [ "$(uname -m)" = "ppc64le" ]; then
    ninja -j1
else
    ninja
fi

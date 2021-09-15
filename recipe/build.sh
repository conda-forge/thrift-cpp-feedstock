#!/bin/env bash
# Get an updated config.sub and config.guess
cp $BUILD_PREFIX/share/libtool/build-aux/config.* .

set -e
set -x

BOOST_ROOT=$PREFIX
ZLIB_ROOT=$PREFIX
LIBEVENT_ROOT=$PREFIX

export OPENSSL_ROOT=$PREFIX
export OPENSSL_ROOT_DIR=$PREFIX
export M4="$(which m4)"

pushd "$SRC_DIR"

mkdir cmake-build
pushd cmake-build
cmake ${CMAKE_ARGS} \
    -DCMAKE_INSTALL_PREFIX=$PREFIX \
    -DBUILD_SHARED_LIBS=ON \
    -DBUILD_PYTHON=OFF \
    -DBUILD_HASKELL=OFF \
    -DBUILD_JAVA=OFF \
    -DBUILD_JAVASCRIPT=OFF \
    -DBUILD_NODEJS=OFF \
    -DBUILD_C_GLIB=OFF \
    -DBUILD_TUTORIALS=OFF \
    -DCMAKE_FIND_ROOT_PATH="$PREFIX" \
    -DBUILD_TESTING=OFF \
    -DBoost_INCLUDE_DIRS=${PREFIX}/include \
    -GNinja \
    ..

# Be explicit about tutorials being unwanted.
# Somehow this gets overriden on first run.
cmake -DBUILD_TUTORIALS=OFF .

# Decrease parallelism a bit as we will otherwise get out-of-memory problems
# This is only necessary on Travis
if [ "$(uname -m)" = "ppc64le" ]; then
    ninja -j1
else
    ninja
fi

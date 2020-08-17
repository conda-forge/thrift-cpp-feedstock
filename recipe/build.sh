#!/bin/env bash

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
cmake \
    -DCMAKE_INSTALL_PREFIX=$PREFIX \
    -DBUILD_PYTHON=OFF \
    -DBUILD_HASKELL=OFF \
    -DBUILD_JAVA=OFF \
    -DBUILD_C_GLIB=OFF \
    -DCMAKE_FIND_ROOT_PATH="$PREFIX" \
    -DBUILD_TESTING=OFF \
    -DBoost_INCLUDE_DIRS=${PREFIX}/include \
    -GNinja \
    ..

ninja install

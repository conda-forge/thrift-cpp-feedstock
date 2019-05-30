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
    -DBUILD_PYTHON=off \
    -DBUILD_JAVA=off \
    -DBUILD_C_GLIB=off \
    -DCMAKE_FIND_ROOT_PATH="$PREFIX" \
    -DBUILD_TESTING=off \
    -DBoost_INCLUDE_DIRS=${PREFIX}/include \
    ..

make VERBOSE=1

# TODO(wesm): The unit tests do not run in CircleCI at the moment
# make check

make install

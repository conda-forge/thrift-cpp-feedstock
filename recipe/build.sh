#!/bin/env bash

set -e
set -x

BOOST_ROOT=$PREFIX
ZLIB_ROOT=$PREFIX
LIBEVENT_ROOT=$PREFIX

export OPENSSL_ROOT=$PREFIX
export OPENSSL_ROOT_DIR=$PREFIX

pushd "$SRC_DIR"

cmake \
    -DCMAKE_INSTALL_PREFIX=$PREFIX \
    -DBUILD_PYTHON=off \
    -DBUILD_JAVA=off \
    -DBUILD_C_GLIB=off \
    -DCMAKE_FIND_ROOT_PATH="$PREFIX" \ 
    -DBUILD_TESTING=off \
    .

make

# TODO(wesm): The unit tests do not run in CircleCI at the moment
# make check

make install

#!/bin/env bash

BOOST_ROOT=$PREFIX
ZLIB_ROOT=$PREFIX
LIBEVENT_ROOT=$PREFIX

export OPENSSL_ROOT=$PREFIX
export OPENSSL_ROOT_DIR=$PREFIX

cmake \
	-DCMAKE_INSTALL_PREFIX=$PREFIX \
	-DBUILD_PYTHON=off \
	-DBUILD_JAVA=off \
	-DBUILD_C_GLIB=off \
	-DCMAKE_FIND_ROOT_PATH=$PREFIX \
	-DNO_CMAKE_SYSTEM_PATH=true \
	-DNO_SYSTEM_ENVIRONMENT_PATH=true \
	-DNO_DEFAULT_PATH=true \
  -DBUILD_TESTING=off \
	.

make

# TODO(wesm): The unit tests do not run in CircleCI at the moment
# make check

make install

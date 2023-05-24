#!/bin/bash
set -ex

cd cmake-build
ninja install

if [[ "$PKG_NAME" == libthrift ]]; then
    rm $PREFIX/bin/thrift
fi

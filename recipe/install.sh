#!/bin/bash
set -ex

cd cmake-build
cmake --install .

if [[ "$PKG_NAME" == libthrift ]]; then
    rm $PREFIX/bin/thrift
fi

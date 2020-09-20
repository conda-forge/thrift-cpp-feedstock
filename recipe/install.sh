#!/bin/bash

set -exo pipefail

pushd cmake-build
ninja install

if [[ "$PKG_NAME" == libthrift ]]; then
    rm $PREFIX/bin/thrift
fi

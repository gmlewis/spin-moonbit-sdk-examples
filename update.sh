#!/bin/bash -ex
DIRS="hello-world kv-store llm now outbound-http redis variables"
for i in ${DIRS}; do
    pushd $i > /dev/null
    moon update && moon install && rm -rf target
    moon fmt
    # As of moonc v0.6.31+b5b06ff93, `--target native` no longer works.
    # moon test --target all
    moon test --target wasm-gc
    moon test --target wasm
    moon test --target js
    popd > /dev/null
done

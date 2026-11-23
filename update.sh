#!/bin/bash -ex
DIRS="hello-world kv-store llm now outbound-http redis variables"
for i in ${DIRS}; do
    pushd $i > /dev/null
    moon update && rm -rf _build target
    moon fmt && moon info
    # As of moonc v0.6.31+b5b06ff93, `--target native` no longer works.
    # moon test --target all
    moon test --target wasm-gc --deny-warn
    moon test --target wasm --deny-warn
    moon test --target js --deny-warn
    popd > /dev/null
done

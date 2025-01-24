#!/bin/bash -ex
DIRS="hello-world kv-store llm now outbound-http redis variables"
for i in ${DIRS}; do
    pushd $i > /dev/null
    moon update && moon install && rm -rf target
    moon fmt
    moon test --target all
    popd > /dev/null
done

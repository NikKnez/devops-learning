#!/bin/bash
# Memory intensive task
array=()
while true; do
    array+=("$(seq 1 1000000)")
    sleep 1
done

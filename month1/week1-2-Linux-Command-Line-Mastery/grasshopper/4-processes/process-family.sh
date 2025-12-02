#!/bin/bash

echo "Parent: $$"

# Spawn multiple children
for i in 1 2 3; do
    sleep 100 &
    echo "Child $i: $!"
done

wait

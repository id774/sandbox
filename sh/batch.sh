#!/bin/bash

process() {
    echo $1
}

batch() {
    while [ $# -gt 0 ]
    do
        process $1
        shift
    done
}

data() {
    echo "1 2 3"
}

batch `data`

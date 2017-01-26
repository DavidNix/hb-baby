#!/usr/bin/env bash

set -e

exiting() {
    echo "Exiting"
    exit 1
}

usage() {
    echo 'usage: hb-baby [input/source] [output]'
    exiting
}

scan() {
    RESULTS="$(HandBrakeCLI -i $INPUT -t 0 --min-duration 500)"

    echo 'results'
    echo "${RESULTS}"

    echo 'titles'
    TITLES="$(grep '+ title [0-9]' | awk '{ print $3 }' | sed 's/://')"
    echo "${TITLES}"
}

main() {
    INPUT=$1
    OUTPUT=$2

    if [ -z "$INPUT" ]; then
        echo "Input (source) required"
        usage
    fi

    if [ -z "$OUTPUT" ]; then
        echo "Output (file) required"
        usage
    fi
    
    scan
}

main $@

echo 'Complete!'

# grep '+ title [0-9]' | awk '{ print $3 }' | sed 's/://'

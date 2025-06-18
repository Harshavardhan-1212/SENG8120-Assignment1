#!/bin/bash

# Function to calculate volume
calculate() {
    local height=$1
    local width=$2
    local length=$3

    # Validate values are non negative integers
    if ! [[ "$height" =~ ^[0-9]+$ && "$width" =~ ^[0-9]+$ && "$length" =~ ^[0-9]+$ ]]; then
        echo "Error: All values must be non-negative integers." >&2
        return 1
    fi

    # Perform the calculation
    echo $(( height * width * length ))
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    if [[ $# -ne 3 ]]; then
        echo "Usage: $0 <height> <width> <length>"
        exit 1
    fi
    result=$(calculate "$1" "$2" "$3")
    echo "Result: $result"
fi

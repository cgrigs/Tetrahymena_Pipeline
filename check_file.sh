#!/bin/bash

# Check if bashate is installed
if ! command -v bashate &> /dev/null; then
    echo "bashate is not installed. Installing..."
    pip install bashate
fi

# Define a function to check the code quality of a file using bashate
check_file () {
    if [ ! -f "$1" ]; then
        echo "File does not exist"
        return 1
    fi

    bashate_result=$(bashate "$1")
    if [ -z "$bashate_result" ]; then
        echo "No issues found in the file"
    else
        echo "$bashate_result"
    fi
}

# Call the function with the filename of the file you want to check
check_file "$1"

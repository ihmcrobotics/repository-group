#!/bin/bash

# Function to convert human-readable sizes to bytes
size_to_bytes() {
    local size=$(echo $1 | cut -d' ' -f1)
    local unit=$(echo $1 | cut -d' ' -f2)
    size=${size%.*} # Remove decimal part
    case $unit in
        KB) echo $((size * 1024)) ;;
        MB) echo $((size * 1024 * 1024)) ;;
        GB) echo $((size * 1024 * 1024 * 1024)) ;;
        *) echo $size ;;
    esac
}

# Get LFS files, convert sizes to bytes, sort, and print
git lfs ls-files -s |
while IFS= read -r line; do
    if [[ $line =~ (.*)\((.*)\)$ ]]; then
        file_path="${BASH_REMATCH[1]}"
        size_str="${BASH_REMATCH[2]}"
        size_bytes=$(size_to_bytes "$size_str")
        printf "%020d|%s|%s\n" "$size_bytes" "$file_path" "$size_str"
    fi
done |
sort -r |
while IFS='|' read -r size_bytes file_path size_str; do
    echo "${file_path}(${size_str})"
done

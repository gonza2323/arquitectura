#!/bin/bash

# Check if directory argument is provided
if [ $# -eq 0 ]; then
    echo "Usage: $0 <directory>"
    exit 1
fi

directory="$1"
start_delimiter_prefix="# --- Ejercicio "
end_delimiter="# --- end"
mkdir -p "$directory/snippets"

# Loop through all files in the directory
for input_file in "$directory"/*.py; do
    # Check if the file exists and is a regular file
    if [ -f "$input_file" ]; then
        # Initialize flag to track if a fragment has started
        fragment_started=false
        # Loop through the file
        while IFS= read -r line; do
            # Check if the line contains a start delimiter
            if [[ "$line" == "$start_delimiter_prefix"* ]]; then
                # Extract identifier from start delimiter
                identifier=$(echo "$line" | sed -n "s/${start_delimiter_prefix}\(.*\)/\1/p")
                # Start of a new fragment, create a new output file
                output_file="${directory}/snippets/ejercicio${identifier}.py"
                # Initialize fragment content
                fragment_content=""
                fragment_started=true
            elif [[ "$line" == *"$end_delimiter"* ]]; then
                # End of the fragment, remove leading and trailing blank lines, collapse consecutive ones
                echo -e "$fragment_content" | sed '/^$/N;/^\n$/D' | sed -Ez '$ s/\n+$//' > "$output_file"
                fragment_started=false
            elif [ "$fragment_started" = true ]; then
                # Append line to fragment content if a fragment has started
                fragment_content+="$line\n"
            fi
        done < "$input_file"
    fi
done

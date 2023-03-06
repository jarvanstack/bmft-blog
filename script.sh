#!/bin/bash

# Define the usage message
usage() {
  echo "Usage: $0 <down|merge> <input> [<output>]"
  printf 'Example:
  ./script.sh down docs/script.bk docs/lib/
  ./script.sh merge docs/lib/ docs/lib/merge.js
  '
  exit 1
}

# Check that at least two arguments were provided
if [ "$#" -lt 2 ]; then
  usage
fi

# Parse the command line arguments
action="$1"
input="$2"
output="$3"

# Handle the "down" action
if [ "$action" = "down" ]; then
  # Create the output directory if it doesn't exist
  mkdir -p "$output"
  # Download all script files referenced in the input HTML file
  grep -o 'src="[^"]*"' "$input" | sed 's/src="//;s/"$//' | while read url; do
    echo "downloading $url"
    curl -L "$url" > "$output/$(basename "$url")"
  done

# Handle the "merge" action
elif [ "$action" = "merge" ]; then
  # traverse the input directory and use uglifyjs to minify each file
  for file in "$input"/*.js; do
    uglifyjs "$file" -o "$file"
  done

  # Combine all script files in the input directory into a single output file
  cat "$input"/*.js > "$output"
  echo "merged files in $input to $output"
# Handle an unknown action
else
  usage
fi

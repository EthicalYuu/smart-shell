#!/bin/bash

Help()
{
  echo "This script performs comprehensive file analysis in a given directory."
  echo "It searches for all files with a specific extension in the given directory and its subdirectories,"
  echo "generates a comprehensive report including file details like size, owner, permissions, and last modified timestamp,"
  echo "groups the files by owner, sorts the file groups by the total size occupied by each owner,"
  echo "and saves the report in a file named 'file_analysis.txt'."
  echo ""
  echo "Users of this script can filter files based on size, permissions, or last modified timestamp,"
  echo "enabling customized search criteria, and have the ability to generate a summary report"
  echo "that displays total file count, total size, and other relevant statistics."
  echo ""
  echo "Usage:"
  echo ""
  echo "  $0 <option>"
  echo "  $0 <directory path> <extensions> [options]"
  echo ""
  echo "Options:"
  echo ""
  echo "  -h      Display this help message"
  echo "  -s      Filter based on the size of the files"
  echo "  -p      Filter based on the permissions"
  echo "  -ts     Filter based on the time stamp"
  echo "  -r      Generate a summary report that displays total file count, total size, and other relevant statistics"
  echo ""
  echo "Example usage:"
  echo ""
  echo "  $0 -h"
  echo "  $0 <directory path> <extensions> -s <size>"
  echo "  $0 <directory path> <extensions> -p <permission>"
  echo "  $0 <directory path> <extensions> -ts <time stamp>"
  echo "  $0 <directory path> <extensions> -r"
  echo ""
}

while getopts ":h" option; do
	echo $option
   case $option in
      h) # display Help
         Help
         exit;;

      \?) # Invalid option
         echo "Error: Invalid option"
         exit;;
   esac
done

initialize_find() {
  local directory="$1"
  shift
  local extensions=("$@")

  local find_command="find \"$directory\" -type f \( "
  for extension in "${extensions[@]}"; do
    find_command+="-name \"*.$extension\" -o "
  done
  find_command+=" -false \)"

  echo "$find_command"
}

# Check if the directory path argument is provided
if [ -z "$1" ]; then
  echo "Please provide a directory path."
  exit 1
fi

# Check if the directory exists
if [ ! -d "$1" ]; then
  echo "Directory not found: $1"
  exit 1
fi

# Check if at least one file extension is provided
if [ $# -lt 2 ]; then
  echo "Please provide at least one file extension."
  exit 1
fi

r_option_found=false

# Get the directory path and remove trailing slash if present
directory="${1%/}"

# Create an array of file extensions
extensions=("${@:2}")

# Initialize the find command
find_command=$(initialize_find "$directory" "${extensions[@]}")

declare -A options=(
  ["-s"]="-size"
  ["-p"]="-perm"
  ["-ts"]="-newermt"
)

args=("$@")
for ((i = 0; i < ${#args[@]}; i++)); do
  arg="${args[i]}"

  if [[ "${options["$arg"]+defined}" = "defined" ]]; then
    option="${options["$arg"]}"
    ((i++))
    value="${args[i]}"
    find_command+=" $option $value"
  fi

  if [[ "$arg" == "-r" ]]; then
    r_option_found=true
  fi

done

# Finalize the find command
find_command+=" -exec ls -lh {} \; | awk '{ sum[\$3] += \$5; print } END { for (owner in sum) print \"Total size for\", owner, \":\", sum[owner] }' | sort -k6,6nr "

# Run the find command and save output to file_analysis.txt
eval "$find_command" > file_analysis.txt

if [[ "$r_option_found" = true ]]; then
  find_count=$(eval "$find_command | wc -l")
  find_count=$((find_count - 2))
  echo "Total count: $find_count"

  files=$(eval "$find_command")
  total_size=$(echo "$files" | awk '{sum += $5} END {print sum}') 
  echo "Total size: $total_size" 
  average_size=$((total_size/find_count))
  echo "Average size: $average_size"
fi

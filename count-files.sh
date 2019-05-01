dir=${1:-$PWD}
find "$dir" -type f -maxdepth 1 | wc -l

dir=${1:-$PWD}
pkg_path="$dir/package.json"
echo "scanning $pkg_path"

for dep in $(jq -r '.dependencies | keys | .[]' $pkg_path); do
  if ! grep "require\(.*$dep.*\)" -Rq --exclude-dir="node_modules" $dir; then
    echo "You can probably remove $dep"
  fi
done
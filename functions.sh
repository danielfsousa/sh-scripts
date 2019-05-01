global=123

test() {
  if [[ $USER = 'danielfsousa' ]]; then
    echo "true"
  elif [[ 1 -eq 1 ]]; then
    echo "elif true"
  else
    echo "false"
  fi

  echo "global = $global"
  local local_var="i'm a local"
  echo "local_var = $local_var"
}

extract() {
  case "$1" in
    *.tar|*.tgz) tar -xzvf "$1";;
    *.gz) gunzip -k "$1";;
    *.zip) unzip -v "$1";;
    *)
      echo "Cannot extract $1"
      exit 1
    ;;
  esac
}

check_status() {
  local status=$(curl -ILs $1 | head -n 1 | cut -d ' ' -f 2)
  if [[ $status -lt 200 ]] || [[ $status -gt 299 ]]; then
    echo "$1 failed with a $status"
  else
    echo "$1 succeeded with a $status"
  fi
}

check_status $1
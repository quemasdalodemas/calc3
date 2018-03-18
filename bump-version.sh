#!/bin/bash -eu

readonly MAIN_FILE="calc.html"

function currentVersion() {
  grep "var version='" "$MAIN_FILE" | cut -d "'" -f 2
}

function hasVersion() {
  grep "var version='$1'" "$MAIN_FILE" > /dev/null 2>&1;
}
function updateVersion() {
  sed -i "s/^\([ ]*\)var version='$1'$/\1var version='$2'/g" "$MAIN_FILE"
}

if hasVersion "$1"; then
  updateVersion "$1" "$2"
  echo "Files modified successfully, version bumped to $2."
else
  echo "Cannot bump version to $2: current version is $(currentVersion) not $1."
fi

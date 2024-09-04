#! /bin/bash

set -e

pushd stow

for d in *; do
  TARGET=$HOME
  echo "Stowing stow/"$d" to "$TARGET
  mkdir -p $TARGET
  stow $d -t $TARGET
done

popd

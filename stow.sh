#! /bin/bash

set -e

stow home -t $HOME

pushd config

for d in *
do
    TARGET=$HOME/.config/$d
    echo "Stowing config/"$d" to "$TARGET
    mkdir -p $TARGET
    stow $d -t $TARGET
done

popd


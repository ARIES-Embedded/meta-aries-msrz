#!/bin/sh

if test -z "$XDG_RUNTIME_DIR"; then
    export XDG_RUNTIME_DIR=/run/user/$UID
    mkdir -p $XDG_RUNTIME_DIR
fi

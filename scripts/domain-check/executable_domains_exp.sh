#!/usr/bin/env bash

DIR="$(dirname "$(realpath "$0")")"

$DIR/domain-check-2.sh -f $DIR/domain-list.txt

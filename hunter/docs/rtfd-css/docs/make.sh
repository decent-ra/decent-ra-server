#!/bin/bash -e

set -x

rm -rf _build _static

mkdir _static

sphinx-build -W . _build

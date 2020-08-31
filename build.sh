#!/bin/bash

# Create directories
mkdir -p intermediate
mkdir -p intermediate/platforms_bare
mkdir -p intermediate/platforms

# Composite objects
echo "Compositing platform sprites"
../cargopositor/cargopositor.exe -o intermediate/platforms_bare -v voxels -t positor/platform_objects.json

# Crowds
echo "Compositing platform sprites (with crowds)"
../cargopositor/cargopositor.exe -o intermediate/platforms -v intermediate/platforms_bare -t positor/crowds.json


# Render sprites
echo "Rendering platforms"
../gorender/renderobject.exe -m files/manifest_platform.json -p -8 -s 1,2 -r -u intermediate/platforms/*.vox
echo ""

# Create NFO
echo "Creating NFO"
../stationer/stationer.exe > test.nfo

# Compile GRF
../grfcodec/grfcodec.exe -g 2 -e test.nfo .

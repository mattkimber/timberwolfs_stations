#!/bin/bash

# Create directories
mkdir -p intermediate
mkdir -p intermediate/platforms_bare
mkdir -p intermediate/platforms_objects
mkdir -p intermediate/platforms
mkdir -p intermediate/bridges

# Basic objects (lamps/shelters)
# one per platform type
echo "Compositing platform sprites (lamps/shelters)"
../cargopositor/cargopositor.exe -o intermediate/platforms_bare -v voxels -t positor/objects_concrete.json
../cargopositor/cargopositor.exe -o intermediate/platforms_bare -v voxels -t positor/objects_modern.json


# Decor objects (benches/signs)
echo "Compositing platform sprites (base objects)"
../cargopositor/cargopositor.exe -o intermediate/platforms_objects -v intermediate/platforms_bare -t positor/platform_objects.json
../cargopositor/cargopositor.exe -o intermediate/platforms_objects -v intermediate/platforms_bare -t positor/platform_objects_bare.json


# Crowds
echo "Compositing platform sprites (with crowds)"
../cargopositor/cargopositor.exe -o intermediate/platforms -v intermediate/platforms_objects -t positor/crowds.json

echo "Compositing bridge sprites (with crowds)"
../cargopositor/cargopositor.exe -o intermediate/bridges -v intermediate/platforms_objects -t positor/crowds_bridge.json


# Render sprites
echo "Rendering platforms"
../gorender/renderobject.exe -m files/manifest_platform.json -p -8 -s 1,2 -r -u intermediate/platforms/*.vox
echo ""

echo "Rendering bridges"
../gorender/renderobject.exe -m files/manifest_object.json -p -8 -s 1,2 -r -u intermediate/bridges/*.vox
echo ""


# Create NFO
echo "Creating NFO"
../stationer/stationer.exe > test.nfo

# Compile GRF
../grfcodec/grfcodec.exe -g 2 -e test.nfo .

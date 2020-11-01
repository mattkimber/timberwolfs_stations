#!/bin/bash

# Create directories
mkdir -p intermediate
mkdir -p intermediate/platforms_bare
mkdir -p intermediate/platforms_objects
mkdir -p intermediate/platforms_crowds
mkdir -p intermediate/ramps_crowds
mkdir -p intermediate/platforms
mkdir -p intermediate/bridges
mkdir -p intermediate/bufferstops


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
../cargopositor/cargopositor.exe -o intermediate/platforms_crowds -v intermediate/platforms_objects -t positor/crowds.json

echo "Compositing bridge sprites (with crowds)"
../cargopositor/cargopositor.exe -o intermediate/bridges -v intermediate/platforms_objects -t positor/crowds_bridge.json

echo "Compositing ramp sprites (with crowds)"
../cargopositor/cargopositor.exe -o intermediate/ramps_crowds -v intermediate/platforms_objects -t positor/crowds_ramp.json

# Fences
echo "Compositing platform sprites (fences)"
../cargopositor/cargopositor.exe -o intermediate/platforms -v intermediate/platforms_crowds -t positor/fences_modern.json
../cargopositor/cargopositor.exe -o intermediate/platforms -v intermediate/platforms_crowds -t positor/fences_concrete.json

echo "Compositing ramp sprites (fences)"
../cargopositor/cargopositor.exe -o intermediate/platforms -v intermediate/ramps_crowds -t positor/fences_modern_ramp_1.json
../cargopositor/cargopositor.exe -o intermediate/platforms -v intermediate/ramps_crowds -t positor/fences_modern_ramp_2.json
../cargopositor/cargopositor.exe -o intermediate/platforms -v intermediate/ramps_crowds -t positor/fences_concrete_ramp_1.json
../cargopositor/cargopositor.exe -o intermediate/platforms -v intermediate/ramps_crowds -t positor/fences_concrete_ramp_2.json

# Roofed platforms
echo "Compositing roof supports"
../cargopositor/cargopositor.exe -o intermediate/platforms -v intermediate/platforms_crowds -t positor/roof_supports.json


# Buffers stops
echo "Compositing buffer stops (fences)"
../cargopositor/cargopositor.exe -o intermediate/bufferstops -v voxels/bufferstops -t positor/fences_bufferstop_concrete.json
../cargopositor/cargopositor.exe -o intermediate/bufferstops -v voxels/bufferstops -t positor/fences_bufferstop_modern.json


# Render sprites
echo "Rendering platforms"
../gorender/renderobject.exe -m files/manifest_platform.json -p -8 -s 1,2 -r -u intermediate/platforms/*.vox
echo ""

echo "Rendering buffer stops"
../gorender/renderobject.exe -m files/manifest_bufferstop.json -p -8 -s 1,2 -r -u intermediate/bufferstops/*.vox
echo ""

echo "Rendering bridges"
../gorender/renderobject.exe -m files/manifest_object.json -p -8 -s 1,2 -r -u intermediate/bridges/*.vox
echo ""

echo "Rendering roofs"
../gorender/renderobject.exe -m files/manifest_building.json -p -8 -s 1,2 -r -u voxels/roofs/roof*.vox
echo ""

echo "Rendering buildings"
../gorender/renderobject.exe -m files/manifest_building.json -p -8 -s 1,2 -r -u voxels/buildings/*.vox
echo ""

# Create NFO
echo "Creating NFO"
../stationer/stationer.exe > test.nfo

# Compile GRF
../grfcodec/grfcodec.exe -g 2 -e test.nfo .

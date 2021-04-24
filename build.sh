#!/bin/bash

# Create directories
mkdir -p intermediate
mkdir -p intermediate/platforms_bare
mkdir -p intermediate/platforms_objects
mkdir -p intermediate/platforms_crowds
mkdir -p intermediate/platforms_billboards
mkdir -p intermediate/ramps_crowds
mkdir -p intermediate/platforms
mkdir -p intermediate/bridges
mkdir -p intermediate/bufferstops

mkdir -p intermediate/tiled_wall_shelter
mkdir -p intermediate/tiled_wall_shelter_crowds

mkdir -p intermediate/car_parks


# Basic objects (lamps/shelters)
# one per platform type
echo "Compositing platform sprites (lamps/shelters)"
../cargopositor/cargopositor.exe -o intermediate/platforms_bare -v voxels -t positor/objects_concrete.json
../cargopositor/cargopositor.exe -o intermediate/platforms_bare -v voxels -t positor/objects_modern.json


# Decor objects (benches/signs)
echo "Compositing platform sprites (base objects)"
../cargopositor/cargopositor.exe -o intermediate/platforms_objects -v intermediate/platforms_bare -t positor/platform_objects.json
../cargopositor/cargopositor.exe -o intermediate/platforms_objects -v intermediate/platforms_bare -t positor/platform_objects_bare.json

# Billboards
echo "Compositing platform sprites (base objects)"
../cargopositor/cargopositor.exe -o intermediate/platforms_billboards -v intermediate/platforms_bare -t positor/billboards_wooden.json
../cargopositor/cargopositor.exe -o intermediate/platforms_billboards -v intermediate/platforms_bare -t positor/billboards_modern.json
../cargopositor/cargopositor.exe -o intermediate/platforms_billboards -v intermediate/platforms_bare -t positor/billboards_concrete.json

# Crowds
echo "Compositing platform sprites (with crowds)"
../cargopositor/cargopositor.exe -o intermediate/platforms_crowds -v intermediate/platforms_objects -t positor/crowds.json

echo "Compositing bridge sprites (with crowds)"
../cargopositor/cargopositor.exe -o intermediate/bridges -v intermediate/platforms_objects -t positor/crowds_bridge.json

echo "Compositing ramp sprites (with crowds)"
../cargopositor/cargopositor.exe -o intermediate/ramps_crowds -v intermediate/platforms_objects -t positor/crowds_ramp.json

echo "Compositing billboard sprites (with crowds)"
../cargopositor/cargopositor.exe -o intermediate/platforms -v intermediate/platforms_billboards -t positor/crowds.json


# Fences
echo "Compositing platform sprites (fences)"
../cargopositor/cargopositor.exe -o intermediate/platforms -v intermediate/platforms_crowds -t positor/fences_modern.json
../cargopositor/cargopositor.exe -o intermediate/platforms -v intermediate/platforms_crowds -t positor/fences_concrete.json

echo "Compositing ramp sprites (fences)"
../cargopositor/cargopositor.exe -o intermediate/platforms -v intermediate/ramps_crowds -t positor/fences_modern_ramp_1.json
../cargopositor/cargopositor.exe -o intermediate/platforms -v intermediate/ramps_crowds -t positor/fences_modern_ramp_2.json
../cargopositor/cargopositor.exe -o intermediate/platforms -v intermediate/ramps_crowds -t positor/fences_concrete_ramp_1.json
../cargopositor/cargopositor.exe -o intermediate/platforms -v intermediate/ramps_crowds -t positor/fences_concrete_ramp_2.json

# Tiled wall shelter
echo "Compositing tiled wall shelter"
../cargopositor/cargopositor.exe -o intermediate/tiled_wall_shelter -v intermediate/platforms_bare -t positor/shelter_tiled_wall.json
../cargopositor/cargopositor.exe -o intermediate/tiled_wall_shelter_crowds -v intermediate/tiled_wall_shelter -t positor/crowds.json
../cargopositor/cargopositor.exe -o intermediate/platforms -v intermediate/tiled_wall_shelter_crowds -t positor/shelter_tiled_wall_fences.json


# Roofed platforms
echo "Compositing roof supports"
../cargopositor/cargopositor.exe -o intermediate/platforms -v intermediate/platforms_crowds -t positor/roof_supports.json

# Bufferstop fences
echo "Compositing buffer stop fences"
../cargopositor/cargopositor.exe -o voxels/bufferstops/fences/outer_concrete -v voxels/bufferstops/fences/outer_concrete -t positor/fences_1.json
../cargopositor/cargopositor.exe -o voxels/bufferstops/fences/outer_concrete -v voxels/bufferstops/fences/outer_concrete -t positor/fences_2.json
../cargopositor/cargopositor.exe -o voxels/bufferstops/fences/outer_concrete -v voxels/bufferstops/fences/outer_concrete -t positor/fences_3.json
../cargopositor/cargopositor.exe -o voxels/bufferstops/fences/inner_concrete -v voxels/bufferstops/fences/inner_concrete -t positor/fences_1.json
../cargopositor/cargopositor.exe -o voxels/bufferstops/fences/inner_concrete -v voxels/bufferstops/fences/inner_concrete -t positor/fences_2.json
../cargopositor/cargopositor.exe -o voxels/bufferstops/fences/inner_concrete -v voxels/bufferstops/fences/inner_concrete -t positor/fences_3.json

../cargopositor/cargopositor.exe -o voxels/bufferstops/fences/outer_modern -v voxels/bufferstops/fences/outer_modern -t positor/fences_1.json
../cargopositor/cargopositor.exe -o voxels/bufferstops/fences/outer_modern -v voxels/bufferstops/fences/outer_modern -t positor/fences_2.json
../cargopositor/cargopositor.exe -o voxels/bufferstops/fences/outer_modern -v voxels/bufferstops/fences/outer_modern -t positor/fences_3.json
../cargopositor/cargopositor.exe -o voxels/bufferstops/fences/inner_modern -v voxels/bufferstops/fences/inner_modern -t positor/fences_1.json
../cargopositor/cargopositor.exe -o voxels/bufferstops/fences/inner_modern -v voxels/bufferstops/fences/inner_modern -t positor/fences_2.json
../cargopositor/cargopositor.exe -o voxels/bufferstops/fences/inner_modern -v voxels/bufferstops/fences/inner_modern -t positor/fences_3.json

../cargopositor/cargopositor.exe -o voxels/bufferstops/fences/outer_wooden -v voxels/bufferstops/fences/outer_wooden -t positor/fences_1.json
../cargopositor/cargopositor.exe -o voxels/bufferstops/fences/outer_wooden -v voxels/bufferstops/fences/outer_wooden -t positor/fences_2.json
../cargopositor/cargopositor.exe -o voxels/bufferstops/fences/outer_wooden -v voxels/bufferstops/fences/outer_wooden -t positor/fences_3.json
../cargopositor/cargopositor.exe -o voxels/bufferstops/fences/inner_wooden -v voxels/bufferstops/fences/inner_wooden -t positor/fences_1.json
../cargopositor/cargopositor.exe -o voxels/bufferstops/fences/inner_wooden -v voxels/bufferstops/fences/inner_wooden -t positor/fences_2.json
../cargopositor/cargopositor.exe -o voxels/bufferstops/fences/inner_wooden -v voxels/bufferstops/fences/inner_wooden -t positor/fences_3.json


# Buffers stops
echo "Compositing buffer stops (with fences)"
../cargopositor/cargopositor.exe -o intermediate/bufferstops -v voxels/bufferstops -t positor/fences_bufferstop_concrete.json
../cargopositor/cargopositor.exe -o intermediate/bufferstops -v voxels/bufferstops -t positor/fences_bufferstop_modern.json


../cargopositor/cargopositor.exe -o intermediate/bufferstops -v voxels/bufferstops -t positor/fences_outer_bufferstop_concrete.json
../cargopositor/cargopositor.exe -o intermediate/bufferstops -v voxels/bufferstops -t positor/fences_inner_bufferstop_concrete.json

../cargopositor/cargopositor.exe -o intermediate/bufferstops -v voxels/bufferstops -t positor/fences_outer_bufferstop_modern.json
../cargopositor/cargopositor.exe -o intermediate/bufferstops -v voxels/bufferstops -t positor/fences_inner_bufferstop_modern.json

../cargopositor/cargopositor.exe -o intermediate/bufferstops -v voxels/bufferstops -t positor/fences_outer_bufferstop_wooden.json
../cargopositor/cargopositor.exe -o intermediate/bufferstops -v voxels/bufferstops -t positor/fences_inner_bufferstop_wooden.json


# Car parks
echo "Compositing car park sprites"
../cargopositor/cargopositor.exe -o intermediate/car_parks -v voxels/car_parks -t positor/car_parks.json
../cargopositor/cargopositor.exe -o intermediate/car_parks -v voxels/car_parks -t positor/corner_car_park.json


# Render sprites
echo "Rendering platforms"
ls intermediate/platforms/*.vox | xargs ../gorender/renderobject.exe -m files/manifest_platform.json -p -8 -s 1,2 -r -u 
echo ""

echo "Rendering buffer stops"
ls intermediate/bufferstops/*.vox | xargs ../gorender/renderobject.exe -m files/manifest_bufferstop.json -p -8 -s 1,2 -r -u 
echo ""

echo "Rendering bridges"
../gorender/renderobject.exe -m files/manifest_object.json -p -8 -s 1,2 -r -u intermediate/bridges/*.vox
../gorender/renderobject.exe -m files/manifest_object.json -p -8 -s 1,2 -r -u voxels/bridges/*covered*.vox
../gorender/renderobject.exe -m files/manifest_object.json -p -8 -s 1,2 -r -u voxels/bridges/pillars/*.vox
echo ""

echo "Rendering roofs"
../gorender/renderobject.exe -m files/manifest_building.json -p -8 -s 1,2 -r -u voxels/roofs/roof*.vox
../gorender/renderobject.exe -m files/manifest_platform.json -p -8 -s 1,2 -r -u voxels/glass/*.vox
echo ""


echo "Rendering buildings"
../gorender/renderobject.exe -m files/manifest_building.json -p -8 -s 1,2 -r -u voxels/buildings/*.vox
echo ""

echo "Rendering car parks"
../gorender/renderobject.exe -m files/manifest_building.json -p -8 -s 1,2 -r -u intermediate/car_parks/*.vox
echo ""


echo "Rendering waypoints"
../gorender/renderobject.exe -m files/manifest_waypoint.json -p -8 -s 1,2 -r -u voxels/waypoints/*.vox
../gorender/renderobject.exe -m files/manifest_waypoint_base.json -p -8 -s 1,2 -r -u voxels/waypoints/base/*.vox
echo ""

echo "Rendering standalone fences"
../gorender/renderobject.exe -m files/manifest_platform.json -p -8 -s 1,2 -r -u voxels/rail_fences/*.vox
echo ""

# Create NFO
echo "Creating NFO"
../stationer/stationer.exe > timberwolfs_stations.nfo

# Compile GRF
../grfcodec/grfcodec.exe -g 2 -e timberwolfs_stations.nfo .

# Build TAR
echo "Building TAR"
mkdir -p timberwolfs_stations
mv *.grf timberwolfs_stations
cp grf_readme/* timberwolfs_stations
tar -c timberwolfs_stations > timberwolfs_stations.tar

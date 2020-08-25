#!/bin/bash

# Render sprites

# Platforms
../gorender/renderobject.exe -m files/manifest_platform.json -p -8 -s 1 -r -u voxels/platforms/*.vox

# Create NFO
../stationer/stationer.exe > test.nfo

# Compile GRF
../grfcodec/grfcodec.exe -e test.nfo .

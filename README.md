# Timberwolf's Stations

A British-style station set with three different eras of
modular platforms, a small selection of station buildings
and custom waypoints based on British signal boxes.

All sprites are available in 2x zoom to match the other
Timberwolfean sets.

## Getting Started

Platforms and concourses are organised by surface type.
There are 3 included by default:

* Wooden (available in any year)
* Concrete (available from 1860)
* Modern (available from 1970)

Some platform structures are not introduced until later
years. Once a platform, building or structure is available
it can be built indefinitely - this is so you can
"refurbish" your old stations or "move" your historic 
signal boxes long after their build date.

## Halls, Concourses and Buffer Stops

Unlike most station NewGRFs, the large station hall
will automatically attempt to determine the correct
combination of large and small roof structures. You
can build different station halls by building
platforms 1 (or 2) at a time, or building the station
in several sections of different length.

A couple of decorative concourses are also offered,
these can be used to link platforms or extend a station.
As you build a concourse the fences around the edge
will automatically adapt.

Buffer stops are also configured automatically.
When you place a buffer stop, it will have track 
connections at both ends. Start building track or
station tiles in the chosen direction and the buffer
stop will automatically configure itself. (Note that
tracks must still match the direction of the buffer
stop, 3 and 4-way buffer stops on a single tile
are not supported)

## Single-sided Platforms

Using a combination of the single-sided "inner" and
"outer" platforms it is possible to build island
stations, outer platforms and small single-platform
halts. This is cosmetic only; it has no gameplay
effect.

## Building from source

Building from source is unfortunately not user-friendly. You will need to build a lot of prerequisites and
have access to the GNU tools, either via a Linux or Mac environment or Windows via Git Bash or WSL.

(Note that the executables are expected to have Windows-style names, take note if you are building the
Go projects on a different platform)

### Prerequisites

You will need to obtain and build the following:

* [GoRender](https://github.com/mattkimber/gorender) - used for rendering voxel objects.
* [Cargopositor](https://github.com/mattkimber/cargopositor) - used for compositiing cargo and animation objects.
* [Stationer](https://github.com/mattkimber/stationer) - used to create the NFO file which defines the GRF.


The build expects to find prerequisites in the following relative folder structure (note `.exe` extension):

* Stationer: `../stationer/stationer.exe`
* GoRender: `../gorender/renderobject.exe`
* Cargopositor: `../cargopositor/cargopositor.exe`

### Building

To build the full set, run `./build.sh`. This will take a while as it needs to composite
and render every combination of platform and structure.
Future runs will not overwrite files, to re-render something you will need to delete its PNG file from
the `2x` directory. (Files will be automatically overwritten if the inputs are newer, assuming
you are using suitably recent versions of Cargopositor and GoRender)
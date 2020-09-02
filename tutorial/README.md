# How to make stations in NFO

While making this set I found there wasn't a great amount of information
on making stations for OpenTTD. There were a few helpful forum posts that
got me to the point of at least being able to understand the newgrf specs,
but I found they tended to one of two categories:

* Someone like me who was figuring stuff out, but either never got to the
  point of a working set, or never went back to correct the mistakes
  afterward.
* Tutorials that just gave you some example NFO, said "this is a 3x4 station
  with roof tiles, here are the sprites you need, stick a bunch of these in
  a file and run `nforenum` on it".

In the hope of helping those who want to make a station and run into this
same problem, here's a tutorial. Hopefully I've not made too many mistakes
that I'll forget to correct later.

## The inevitable bit about NFO

I don't want to spend too much time going "how to NFO" as there are plenty
of good tutorials on that side of things, but it might help to see NFO as
I understand it.

Once you get past the header (which is mainly directions for `grfcodec`) each
line of NFO is one of the following:

* A realsprite, consisting of a filename followed by information on how to display it.
* A pseudosprite, which will be followed by actions. More on these in a bit.
* An alternative sprite, which is like a realsprite but allows specifying alternative
  zoom levels and colour depths.

Real and psuedo sprites have a line number, which starts at 0 and is incremented by
1 for each line. Alternative sprites don't - instead they start with a "|", and must
follow the real sprite they're an alternative for.

Pseudosprites are the interesting part. These are where the logic that turns your
NFO file from a static list of sprites to a functioning NewGRF is created. A typical
pseudosprite looks something like this:

`33 * 65 00 04 03 01 ...`

Let's split this up:

```
     33         *            65            00         04 03 01 ...
    Line      Pseudo-      Length of     Action       Data
   number     sprite       line in        (HEX)       (HEX)
             identifier     bytes
```

Ever programmed in assembler? This might look a little familiar...
For me, NFO pseudosprites work like an assembly language, but for NewGRFs.
Once you get past the metadata about line numbers and lengths, each line has
an instruction, followed by some data that instruction operates on.

The instructions (or Actions) are listed in the newgrf specs, and this
is the place to go if you want more detail on how one works or what the
available values are. The downside is that documentation in the specs
tends to be terse but accurate, meaning that while you can always find
out what an action allows, it's not always clear how you'd create things
with it.

## grfcodec and its headers

A typical NFO file doesn't start with line 0, it has three lines of
headers. You need all three, as I found after some unfortunate experimentation.

```
// Hand-generated with love. Do modify!
// (Info version 32)
// Format: spritenum imagefile depth xpos ypos xsize ysize xrel yrel zoom flags
```

The first line is ignored. Yes, everyone will tell you to keep the standard
GRFcodec message, but this is genuinely just a comment. As long as you have
a single line starting with a `//` the file will compile.

The next line tells `grfcodec` the NFO file version. To make a GRF file with
extra zoom and/or 32bpp sprites this needs to be `// (Info version 32)`
as above. You can use version `7` if you need old style syntax or
compatibility with ancient OpenTTD versions.

The final line is a little odd - it looks like it's telling `grfcodec` how
to lay things out but actually this is more a reminder for the person
editing the NFO file. As long as this line starts with `// Format:` then
`grfcodec` will run. There's no benefit in doing anything innovative here
though, so the standard one is fine and might help remind you which number
is which.

One last note on `grfcodec`: even if you declare version `32` it will use
container file version 1, which doesn't support the extra sprites.

To build a GRF which supports extra zoom, you need to explicitly specify
the container version with the `-g` flag on the command line:

`grfcodec -g 2 -e mynfofile.nfo`

## Building a basic station

What's the minimum needed for the most basic working station?

* The three header lines
* A sprite 0 telling `grfcodec` how many lines are in your NFO file
* An Action 14 telling OpenTTD to use the Default palette
* An Action 8 for the set ID, name and description
* An Action 1 to define a list of real sprites
* Sprites for a single platform in each of the two cardinal directions
* An Action 0 to declare the station, set its class, and its layout.
  (Action 0 lines are complex, more on these later)
* An Action 2 to define a *spriteset* using the real sprites from the
  Action 1.
* An Action 3 to link the spriteset to the station declared in action 0
* An Action 4 to create a text string for the station object
* An Action 4 to create a text string for the class name

### The header

As mentioned earlier, you need the following header lines:

```
// Very Simple Station
// (Info version 32)
// Format: spritenum imagefile depth xpos ypos xsize ysize xrel yrel zoom flags
```

### Sprite 0

This is a good point to introduce the way NFO handles numbers.

* Sprite numbers are in decimal.
* Line lengths are in decimal.
* Actions and data are in little-endian hexadecimal (i.e. read right to left).

This makes NFO rather frustrating to hand-code, especially since many hex conversion
utilities (the Windows calculator among them) give you hexadecimal in big-endian format.
This means that if Windows calculator is showing 15C1 and you need a four-byte number,
you need to reverse it, work out how many implicit zeros, and type C1 15 00 00 into
NFO.

Sprite 0 is a pseudosprite with a 4-byte number indicating how many lines are in
your file. I think `nforenum` will generate this for you automatically, so just run
that on your NFO file and don't worry too much about counting bytes and lines.

With this in mind, sprite 0 should look something like this:

```
0 * 4 D5 00 00 00
```

Note that the byte count doesn't include the line number or anything like that,
only the length of the data.

### Action 14

This needs to come before the Action 8.

```
1 * 38	 14 "C" "INFO" "B" "PALS" 01 00 "D" "B" "VRSN" 04 00 01 00 00 00 "B" "MINV" 04 00 01 00 00 00 00 00
```

### Action 8

```
2 * 48	 08 08 "DMO" 01 "Simple Stations" 00 "A set of simple platforms" 00
```

### Action 1

We want to start with the simplest possible station that actually demonstrates something useful -
a single platform on one side of the tracks. Yes, this is simpler than the "default" OpenTTD
station with two platforms! That's because OpenTTD stations are built up component by component.


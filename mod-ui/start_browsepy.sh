#!/bin/bash

/usr/bin/mkdir -p "$1/Audio Loops"
/usr/bin/mkdir -p "$1/Audio Recordings"
/usr/bin/mkdir -p "$1/Audio Samples"
/usr/bin/mkdir -p "$1/Audio Tracks"
/usr/bin/mkdir -p "$1/MIDI Clips"
/usr/bin/mkdir -p "$1/MIDI Songs"
/usr/bin/mkdir -p "$1/Reverb IRs"
/usr/bin/mkdir -p "$1/Speaker Cabinets IRs"
/usr/bin/mkdir -p "$1/Hydrogen Drumkits"
/usr/bin/mkdir -p "$1/SF2 Instruments"
/usr/bin/mkdir -p "$1/SFZ Instruments"
/usr/bin/mkdir -p "$1/Aida DSP Models"
/usr/bin/mkdir -p "$1/NAM Models"

nohup /mod/mod-ui/modui-env/bin/browsepy --directory $1 --upload $1 --removable $1  0.0.0.0 8081 &


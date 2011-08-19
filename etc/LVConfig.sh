#!/bin/bash

# LabView Executable
LabViewBin="/c/Program Files/National Instruments/LabVIEW 2009/LabVIEW.exe"

# LabView Shared Path for Compare and Merge
LabViewShared="/c/Program Files/National Instruments/Shared"

## DO NOT EDIT FROM HERE ON UNLESS YOU REALLY REALLY KNOW WHAT YOU ARE DOING

# sed RegEx to replace / by \ in Path
PATHFIX='s/\//\\/g'
# sed RegEx to replace trailing ./ with \
TRAILFIX='s/^.\//\\/'
# Remove ending / or \
ENDFIX='s/[\\/]+$//g'
# Make Path suitable for Windows (C: instead of /c)
MKWINPATH='s/^\/\([a-z]\)/\U\1:/'
# Check if Path is abolsute: if either ^/@/ or ^@:\ where @ is the drive letter
ABSPATH='^([a-zA-Z]:\\|/[a-zA-Z]/)'

# Repository directory in windows path notation
WD=$(pwd | sed -e "${ENDFIX}" | sed -e "${MKWINPATH}" | sed -e  "${PATHFIX}")
# LVCompare.exe needs this path in Windows format
LabViewBin=$(echo $LabViewBin | sed -e "${MKWINPATH}" | sed -e "${PATHFIX}")

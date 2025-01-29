#!/bin/bash

# cd openscad/ ; bash ./output-files.sh ; cd ..


WORK_DIR=`mktemp -d `

# check if tmp dir was created
if [[ ! "$WORK_DIR" || ! -d "$WORK_DIR" ]]; then
  echo "Could not create temp dir"
  exit 1
fi

# deletes the temp directory
function cleanup {      
  rm -rf "$WORK_DIR"
  echo "Deleted temp working directory $WORK_DIR"
}

# register the cleanup function to be called on the EXIT signal
trap cleanup EXIT



openscad ./flying_wing_KMf-6.scad  -D 'display=1' \
    -D '$vpr = [60, 0, 360 * $t];' \
    -D '$vpd = 1900;' \
    -D 'prop_a = -1890 * $t;' \
    -o "${WORK_DIR}/rotate.png"  \
    --imgsize=1024,768 \
    --animate 120 \
    --viewall --autocenter
    
rm ../images/flying_wing_KMf.gif
    
ffmpeg \
        -framerate 30 \
        -pattern_type glob \
        -i "${WORK_DIR}/*.png" \
        -r 120 \
        -vf scale=512:-1 \
        "../images/flying_wing_KMf.gif" 


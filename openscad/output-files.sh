#!/bin/bash

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


# Display 1
openscad ./flying_wing_KMf-6.scad  -D 'display=1' -o ../images/flying_wing_KMf-6_diagonal.png  --imgsize=1024,768 --viewall --autocenter  --camera=0,0,0,30,-30,30,0
openscad ./flying_wing_KMf-6.scad  -D 'display=1' -o ../images/flying_wing_KMf-6_diagonal_front.png  --imgsize=1024,768 --viewall --autocenter --camera=0,0,0,-30,30,210,0
openscad ./flying_wing_KMf-6.scad  -D 'display=1' -o ../images/flying_wing_KMf-6_front.png  --imgsize=1024,768 --viewall --autocenter --camera=0,0,0,270,0,0,0


# Display 2
openscad ./flying_wing_KMf-6.scad  -D 'display=2' -o ../stl/flying_wing_KMf-6_printed_parts.stl
openscad ./flying_wing_KMf-6.scad  -D 'display=2' -o ../images/flying_wing_KMf-6_prints.png  --imgsize=1024,768 



# Display 3
openscad ./flying_wing_KMf-6.scad  -D 'display=3' -o ../images/flying_wing_KMf-6_foam_sheets.png  --imgsize=1024,768 --viewall --autocenter

# Display 4
openscad ./flying_wing_KMf-6.scad  -D 'display=4' -o ../images/flying_wing_KMf-6_foam_sheets_outline.svg


# SVG files and [single pdf files in temp]
for i in {1..8}
do
    openscad ./flying_wing_KMf-6.scad  -D 'display=5'  -D display_page="$i" -o ../images/flying_wing_KMf-6_page_$i.svg
    inkscape --file=../images/flying_wing_KMf-6_page_$i.svg --without-gui --export-area-page --export-pdf=$WORK_DIR/$i.pdf
done

pdfunite $WORK_DIR/*.pdf ../images/flying_wing_KMf-6_pages.pdf


# Display 6
declare -a parts=("cockpit" "cockpit_front" "leading_edge_half")

echo "####"
for i in "${parts[@]}"
do
    echo ../stl/flying_wing_KMf-6_printed_part_$i.stl
	openscad ./flying_wing_KMf-6.scad  -D 'display=6' -o ../stl/flying_wing_KMf-6_printed_part_$i.stl
done
echo "####"



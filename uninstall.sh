#!/bin/bash
echo "Unistalling lum"
EXECUTABLE="/usr/bin/lum"
DEST_SRC="/usr/share/lum"
rm -rf $DEST_SRC
echo "Removed $DEST_SRC"
rm $EXECUTABLE
echo "Removed $EXECUTABLE"
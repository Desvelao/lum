#!/bin/sh
echo "Unistalling lum"
LUM_BINARY="/usr/bin/lum"
LUM_LIBRARY="/usr/share/lum"
rm -rf $LUM_LIBRARY
echo "Removed $LUM_LIBRARY"
rm $LUM_BINARY
echo "Removed $LUM_BINARY"
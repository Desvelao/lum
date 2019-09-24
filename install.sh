#!/bin/bash
ROCKSPEC=$PWD/$(find . -maxdepth 1 -type f -name *.rockspec)
EXECUTABLE="/usr/bin/lum"
DEST_SRC="/usr/share/lum"
rm -rf $DEST_SRC
cp -r ./lum $DEST_SRC
cp ./uninstall.sh $DEST_SRC/uninstall.sh
chmod 777 $DEST_SRC/uninstall.sh
echo "Copied lum folder to $DEST_SRC"
cd $DEST_SRC && luarocks install lummander
echo "Installed dependencies"
echo "lua5.3 -e 'lum_path=\"$DEST_SRC\";package.path=\"$DEST_SRC/?.lua;$DEST_SRC/?/init.lua;$HOME/.luarocks/share/lua/5.1/?.lua;$HOME/.luarocks/share/lua/5.1/?/init.lua;/usr/local/share/lua/5.1/?.lua;/usr/local/share/lua/5.1/?/init.lua;$HOME/.luarocks/share/lua/5.3/?.lua;$HOME/.luarocks/share/lua/5.3/?/init.lua;/usr/local/share/lua/5.3/?.lua;/usr/local/share/lua/5.3/?/init.lua;\"..package.path;package.cpath=\"$HOME/.luarocks/lib/lua/5.1/?.so;/usr/local/lib/lua/5.1/?.so;$HOME/.luarocks/lib/lua/5.3/?.so;/usr/local/lib/lua/5.3/?.so;\"..package.cpath' $DEST_SRC/lum.lua \"\$@\"" > $EXECUTABLE
echo "Created a executable on $EXECUTABLE"
chmod 777 $EXECUTABLE
echo "Finish. Use lum"
#!/bin/bash
error_exit(){
  echo $1
  $1 || {
     echo "Error lum install.sh: ${2:-"Unknown Error"}" 1>&2
     exit 1
  }
}
EXECUTABLE="/usr/bin/lum"
DEST_SRC="/usr/share/lum"
ORIGIN_PATH="$PWD"
LUM_ENV=${LUM_ENV:-"production"}
CMD_INSTALL_DEPS="luarocks install $([ "$LUM_ENV" = "dev" ] && echo "--server=https://luarocks.org/dev" || echo "") lummander"
echo "> Cloning repository"
error_exit "git clone https://github.com/Desvelao/lum.git" "Couldn't clone lum repository"
echo "> Installing lum"
rm -rf $DEST_SRC || true
error_exit "cp -r lum/lum $DEST_SRC" "Cannot copy lum src to $DEST_SRC"
error_exit "cp lum/uninstall.sh $DEST_SRC/uninstall.sh" "Couldn't uninstall.sh to $DEST_SRC"
chmod 777 $DEST_SRC/uninstall.sh
echo "> Copied lum folder to $DEST_SRC"
error_exit "$CMD_INSTALL_DEPS" "Could't install dependencies. Is it installed Luarocks?"
echo "> Installed dependencies"
echo "lua5.3 -e 'lum_path=\"$DEST_SRC\";lum_env=\"$LUM_ENV\";package.path=\"$DEST_SRC/?.lua;$DEST_SRC/?/init.lua;$HOME/.luarocks/share/lua/5.1/?.lua;$HOME/.luarocks/share/lua/5.1/?/init.lua;/usr/local/share/lua/5.1/?.lua;/usr/local/share/lua/5.1/?/init.lua;$HOME/.luarocks/share/lua/5.3/?.lua;$HOME/.luarocks/share/lua/5.3/?/init.lua;/usr/local/share/lua/5.3/?.lua;/usr/local/share/lua/5.3/?/init.lua;\"..package.path;package.cpath=\"$HOME/.luarocks/lib/lua/5.1/?.so;/usr/local/lib/lua/5.1/?.so;$HOME/.luarocks/lib/lua/5.3/?.so;/usr/local/lib/lua/5.3/?.so;\"..package.cpath' $DEST_SRC/lum.lua \"\$@\"" > $EXECUTABLE
echo "> Created a executable on $EXECUTABLE"
chmod 777 $EXECUTABLE
echo "> Removing lum folder"
error_exit "cd $ORIGIN_PATH && rm -rf lum" "Could't remove repository cloned"
echo "> Instalation success. You can use lum now. Execute lum command to see help"

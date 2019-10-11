#!/bin/bash
error_exit(){
  echo $1
  $1 || {
     echo "Error lum install.sh: ${2:-"Unknown Error"}" 1>&2
     exit 1
  }
}

check_lua_version(){
  if ! [ -z ${LUA_VERSION+x} ]; then
    return 1
  fi
  echo "Checking lua versión... $1"
  local LUA_V=$($1 -v 2>&1 | sed -r 's/Lua (5\.[0-9]).*/\1/')
  if "$LUA_V"  =~ "^5\.[0-9]$" ; then
    return 1
  fi
  LUA_VERSION="$LUA_V"
  LUA_INTERPETER="$1"
  return 0
}

# check_lua_version "lua" || check_lua_version "lua5.1" || check_lua_version "lua5.2" || check_lua_version "lua5.3"

# if [ -z ${LUA_VERSION+x} ]; then
#   echo "Lua isn't installed"
#   exit 1
# fi

EXECUTABLE="/usr/bin/lum"
DEST_SRC="/usr/share/lum"
ORIGIN_PATH="$PWD"
LUM_ENV=${LUM_ENV:-"production"}
LUM_REPOSITORY="https://github.com/Desvelao/lum.git"
LUAROCKS_LUA_VERSION="$(luarocks config lua_version)"
LUAROCKS_LUA_INTERPETER="$(luarocks config lua_interpreter)"
LUA_INTERPETER="$LUAROCKS_LUA_INTERPETER" # same luarocks
LUA_VERSION="$LUAROCKS_LUA_VERSION" # same luarocks
CMD_INSTALL_DEPS="luarocks install $([ "$LUM_ENV" = "dev" ] && echo "--server=https://luarocks.org/dev" || echo "") --lua-version=$LUA_VERSION lummander"

echo "Detected Lua version: $LUA_VERSION"
echo "> Cloning repository"
error_exit "git clone $LUM_REPOSITORY" "Couldn't clone lum repository"
echo "> Installing lum"
rm -rf $DEST_SRC || true # Remove last lum instalation
error_exit "cp -r lum/lum $DEST_SRC" "Couldn't copy lum src to $DEST_SRC"
error_exit "cp lum/uninstall.sh $DEST_SRC/uninstall.sh" "Couldn't uninstall.sh to $DEST_SRC"
chmod 777 $DEST_SRC/uninstall.sh
echo "> Copied lum folder to $DEST_SRC"
echo "> Installing dependencies"
error_exit "$CMD_INSTALL_DEPS" "Could't install dependencies. Is it installed Luarocks?"
echo "> Creating lum executable"
echo "$LUA_INTERPETER -e 'lum_path=\"$DEST_SRC\";lum_env=\"$LUM_ENV\";package.path=\"$DEST_SRC/?.lua;$DEST_SRC/?/init.lua;$HOME/.luarocks/share/lua/$LUA_VERSION/?.lua;$HOME/.luarocks/share/lua/$LUA_VERSION/?/init.lua;/usr/local/share/lua/$LUA_VERSION/?.lua;/usr/local/share/lua/$LUA_VERSION/?/init.lua;\"..package.path;package.cpath=\"$HOME/.luarocks/lib/lua/$LUA_VERSION/?.so;/usr/local/lib/lua/$LUA_VERSION/?.so;\"..package.cpath' $DEST_SRC/lum.lua \"\$@\"" > $EXECUTABLE
# echo "$LUA_INTERPETER -e 'lum_path=\"$DEST_SRC\";lum_env=\"$LUM_ENV\";package.path=\"$DEST_SRC/?.lua;$DEST_SRC/?/init.lua;$HOME/.luarocks/share/lua/5.1/?.lua;$HOME/.luarocks/share/lua/5.1/?/init.lua;/usr/local/share/lua/5.1/?.lua;/usr/local/share/lua/5.1/?/init.lua;$HOME/.luarocks/share/lua/5.2/?.lua;$HOME/.luarocks/share/lua/5.2/?/init.lua;/usr/local/share/lua/5.2/?.lua;/usr/local/share/lua/5.2/?/init.lua;$HOME/.luarocks/share/lua/5.3/?.lua;$HOME/.luarocks/share/lua/5.3/?/init.lua;/usr/local/share/lua/5.3/?.lua;/usr/local/share/lua/5.3/?/init.lua;\"..package.path;package.cpath=\"$HOME/.luarocks/lib/lua/5.1/?.so;/usr/local/lib/lua/5.1/?.so;$HOME/.luarocks/lib/lua/5.2/?.so;/usr/local/lib/lua/5.2/?.so$HOME/.luarocks/lib/lua/5.3/?.so;/usr/local/lib/lua/5.3/?.so;\"..package.cpath' $DEST_SRC/lum.lua \"\$@\"" > $EXECUTABLE
echo "> Created a executable on $EXECUTABLE"
chmod 777 $EXECUTABLE
echo "> Removing lum folder"
error_exit "rm -rf $ORIGIN_PATH/lum" "Could't remove repository cloned"
echo "> Lum src: $DEST_SRC"
echo "> Lum executable: $EXECUTABLE"
echo "> Lua version: $LUA_VERSION"
echo "> Instalation success. You can use lum now. Execute lum command to see help"

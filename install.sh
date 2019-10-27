#!/bin/sh
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

install(){
  echo "Detected Lua version: $LUA_VERSION"
  LUM_VERSION="$1"
  clone_repo $LUM_VERSION
  echo "> Installing lum"
  rm -rf $LUM_LIBRARY || true # Remove last lum instalation
  error_exit "cp -r lum/lum $LUM_LIBRARY" "Couldn't copy lum src to $LUM_LIBRARY"
  error_exit "cp lum/install.sh $LUM_LIBRARY/install.sh" "Couldn't install.sh to $LUM_LIBRARY"
  error_exit "cp lum/uninstall.sh $LUM_LIBRARY/uninstall.sh" "Couldn't uninstall.sh to $LUM_LIBRARY"
  chmod 777 $LUM_LIBRARY/install.sh
  chmod 777 $LUM_LIBRARY/uninstall.sh
  echo "> Copied lum folder to $LUM_LIBRARY"
  echo "> Installing dependencies"
  error_exit "$CMD_INSTALL_DEPS" "Could't install dependencies. Is it installed Luarocks?"
  echo "> Creating lum executable"
  echo "$LUA_INTERPETER -e 'lum_path=\"$LUM_LIBRARY\";lum_env=\"$LUM_ENV\";package.path=\"$LUM_LIBRARY/?.lua;$LUM_LIBRARY/?/init.lua;$HOME/.luarocks/share/lua/$LUA_VERSION/?.lua;$HOME/.luarocks/share/lua/$LUA_VERSION/?/init.lua;/usr/local/share/lua/$LUA_VERSION/?.lua;/usr/local/share/lua/$LUA_VERSION/?/init.lua;\"..package.path;package.cpath=\"$HOME/.luarocks/lib/lua/$LUA_VERSION/?.so;/usr/local/lib/lua/$LUA_VERSION/?.so;\"..package.cpath' $LUM_LIBRARY/lum.lua \"\$@\"" > $LUM_BINARY
  echo "> Created a executable on $LUM_BINARY"
  chmod 777 $LUM_BINARY
  echo "> Removing lum folder"
  error_exit "rm -rf $CURRENT_DIRECTORY/lum" "Could't remove repository cloned"
  echo "> Lua version: $LUA_VERSION"
  echo "> Lum src: $LUM_LIBRARY"
  echo "> Lum executable: $LUM_BINARY"
  echo "> Lum version: ${LUM_VERSION:-"master"}"
  echo "> Instalation success. You can use lum now. Execute lum command to see help"
}

clone_repo(){
  echo "> Cloning repository"
  error_exit "git clone $LUM_REPOSITORY $([ -z "$1" ] && echo "" || echo "--branch $1")" "Couldn't clone lum repository"
}

get_latest_version(){
  LUM_LATEST_VERSION=$(curl --silent "https://api.github.com/repos/desvelao/lum/tags" | grep -m 1 '"name":' | sed -E 's/.*"v([^\"]+)".*/\1/')
}

# check_lua_version "lua" || check_lua_version "lua5.1" || check_lua_version "lua5.2" || check_lua_version "lua5.3"

# if [ -z ${LUA_VERSION+x} ]; then
#   echo "Lua isn't installed"
#   exit 1
# fi

LUM_BINARY="/usr/bin/lum"
LUM_LIBRARY="/usr/share/lum"
CURRENT_DIRECTORY="$PWD"
LUM_ENV=${LUM_ENV:-"production"}
LUM_REPOSITORY="https://github.com/Desvelao/lum.git"
LUAROCKS_LUA_VERSION="$(luarocks config lua_version)"
LUAROCKS_LUA_INTERPETER="$(luarocks config lua_interpreter)"
LUA_INTERPETER="$LUAROCKS_LUA_INTERPETER" # same luarocks
LUA_VERSION="$LUAROCKS_LUA_VERSION" # same luarocks
CMD_INSTALL_DEPS="luarocks install $([ "$LUM_ENV" = "dev" ] && echo "--server=https://luarocks.org/dev" || echo "") --lua-version=$LUA_VERSION lummander"

if [ -z "$1" ] ; then # get latest version
  get_latest_version
  install "$LUM_LATEST_VERSION"

elif [ "$1" = "install" ] ; then # get specified version or latest
  get_latest_version
  install ${2:-"$LUM_LATEST_VERSION"}

elif [ "$1" = "update" ] ; then # update from version
  CURRENT_LUM_VERSION=$2
  get_latest_version
  echo "Current version: $CURRENT_LUM_VERSION"
  echo "Latest version: $LUM_LATEST_VERSION"
  if [ "$CURRENT_LUM_VERSION" \< "$LUM_LATEST_VERSION" ] ; then
    sleep 5
    install "$LUM_LATEST_VERSION"
    echo "Updated to $LUM_LATEST_VERSION"
  else 
    echo "You have last version: $LUM_LATEST_VERSION"
  fi

elif [ "$1" = "get_latest_version" ] ; then # echo latest version
  get_latest_version
  echo $LUM_LATEST_VERSION

fi

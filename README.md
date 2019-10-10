# What is lum?
lum is a commandline application to developers can use easily some commands of npm/git/luarocks and init new projects.

Allow with one only command:
- git add && commit & push
- git tag and push
- create new folder && npm init && git init
# Requirements
- Install Lua 5.3

```bash
curl -R -O http://www.lua.org/ftp/lua-5.3.5.tar.gz
tar zxf lua-5.3.5.tar.gz
cd lua-5.3.5
make linux test
```

- Install [Luarocks](https://luarocks.org/#quick-start)

- Git
- NPM
- [Ldoc](https://stevedonovan.github.io/ldoc/) (optional for run ldoc command)
    ```bash
    luarocks install ldoc
    ```

# Install

Using cURL:
```bash
sudo sh -c "$(curl https://raw.githubusercontent.com/desvelao/lum/master/install.sh)" 
```

Development build
```bash
sudo sh -c "$(curl https://raw.githubusercontent.com/desvelao/lum/master/install.sh) dev" 
```

# Uninstall
Go to lum folder and execute uninstall.sh

```
sudo sh ./uninstall.sh
```

or

```bash
lum uninstall
```
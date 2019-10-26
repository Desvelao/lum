# What is lum?
lum is a commandline application to developers can use easily some commands of npm/git/luarocks and init new projects. Help with developer workflow.

Allow with one only command:
- git add && commit && push
- git tag && push
- create new folder && npm init && git init
- create a `lum_run.lua` file with custom scripts to run with `lum run <script_name>`
- create LICENSE.md file

**Only for linux.**

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

**Only for linux.**

Using cURL:
```bash
sudo sh -c "$(curl https://raw.githubusercontent.com/desvelao/lum/master/install.sh)" 
```

Development build - DEPRECATED
```bash
sudo sh -c "LUM_ENV=\"dev\";$(curl https://raw.githubusercontent.com/desvelao/lum/master/install.sh)" 
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

# Run scripts
Create a `lum_run.lua` file in current directory that returns a table with pairs keys-value. To activate some script use `lum run <script_name>` where `<script_name>` is a key of return table. You can create a `lum_run.lua` file with `lum init`. You can create a `lum_run.lua` under `.lum` folder in your home directory to add global run scripts.

```lua
-- lum_run.lua
return {
    my_script = "echo \"Echoing this with lum run myscript\"",
    function_script = function(app, args) -- can be a function
        -- app: cli instance
        -- args: rest of arguments passed after command script name. It's a table.
        print("Hi from a function script")
    end,
    table_script_run_string = {
        description = "...", -- set description
        run = "echo \"Echo from a script as table with run string\"" -- string/function. If string, description is placed to this
    },
    table_script_run_function = {
        description = "...", -- set description
        run = function(app, args)
            -- script process
        end,
    }
}
```

Run scripts with: `lum run <script_name>`
```bash
$ lum run my_script
Echoing this with lum run my_script
$ lum run function_script
Hi from a function script
```
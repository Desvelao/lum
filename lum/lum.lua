local Lummander = require "lummander"
local pack = pack or table.pack

local lum = Lummander.new{
    title = "lum CLI",
    tag = "lum",
    author = "Desvelao^^",
    version = "0.1.1",
    description = "CLI to help developers with git, npm, init nodejs or luarocks projects",
    theme = "acid",
    root_path = lum_path,
    flag_prevent_help = false,
    devmode = false
}

function lum.print(mode, text)
    mode = mode or "green"
    text = text or mode
    if(mode == "success") then mode = "green"
    elseif(mode == "error") then mode = "red"
    else return error("Log mode is not valid: ".. mode) end
    print(Lummander.chalk[mode](text))
end

local execute = lum.execute

function lum:execute(command, callback)
    print(self.chalk.yellow(command))
    return execute(self, command, callback)
end

function lum:execute_silent(command, callback)
    return execute(self, command, callback)
end

lum.methods = {}
function lum.methods.mkdir(dir)
    lum.methods.print("Creating directory...")
    lum.lfs.mkdir(dir)
    lum.methods.print("Created: ".. dir)
end

function lum.methods.print(message)
    print(lum.chalk.yellow(message))
end

function lum.methods.user_home()
    return lum:execute_silent("echo ${HOME}"):gsub("\n","")
end

function lum.methods.lum_home()
    return lum.methods.user_home() .. "/.lum"
end

function lum.methods.ordered_pairs (t)
    local sorted_t = {}
    for k,v in pairs(t) do
      table.insert(sorted_t, k)
    end
    table.sort(sorted_t)
    local i = 0
    local n = #sorted_t
    return function ()
            i = i + 1
            if i <= n then return sorted_t[i], t[sorted_t[i]] end
    end
end

function lum.read(message)
    return io.read("*l")
end

function lum.methods.commands_dir_user(absolute_path)
    local fstring = require("f.string")
    local original_path = package.path
    package.path = absolute_path .. '/?.lua;'
    local separator = package.config:sub(1,1) -- / or \\ to know OS
    local base_directory = absolute_path
    lum.pcall(function()
        for filename,i in lfs.dir(base_directory) do
            if(fstring.ends_with(filename, ".lua"))then
                local file = filename:sub(1,-5)
                lum.pcall(function()
                    local data = require(file)
                    data.file = file:gsub("%.","/")
                    lum:command(data.command, data.description, data)
                    package.loaded[file] = nil
                end):fail(function(err)
                    lum:error("Command adding from file: " .. file:gsub("%.","/") .. "\n".. err)
                end)
            end
        end
    end):pass(function(result)
        
    end):fail(function(err)
        -- lum.theme.error(err)
    end)
    package.path = original_path
    return lum
end

lum:commands_dir("commands").methods.commands_dir_user(lum.methods.lum_home() .. '/commands')
    :parse(arg)

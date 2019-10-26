local Lummander = require "lummander"
local pack = pack or table.pack

local lum = Lummander.new{
    title = "lum CLI",
    tag = "lum",
    author = "Desvelao^^",
    version = "0.1.0-26/10/19",
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

function lum.methods.get_home()
    return lum:execute_silent("echo ${HOME}"):gsub("\n","")
end

function lum.methods.lum_home()
    return lum.methods.get_home() .. "/.lum"
end

function lum.read(message)
    return io.read("*l")
end

lum:commands_dir("commands")
    :parse(arg)

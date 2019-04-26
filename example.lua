package.path = 'C:/projects/lummander/?/init.lua;C:/projects/lummander/?.lua;C:/projects/lummander/example/?/init.lua;C:/projects/lummander/example/?.lua;' .. package.path
-- package.cpath = '?.dll;./?.dll;' .. package.cpath
local Lummander = require "lummander"
local pack = pack or table.pack

local luc = Lummander.new{
    title = "lum CLI",
    tag = "lum",
    author = "Desvelao^^",
    description = "Lummander tester CLI",
    theme = "acid",
    root_path = "C:/projects/lummander/example",
    flag_prevent_help = false,
    devmode = false
}
-- print(package.searchpath( "lummander", package.path ))

function luc.print(mode, text)
    mode = mode or "green"
    text = text or mode
    if(mode == "success") then mode = "green"
    elseif(mode == "error") then mode = "red"
    else return error("Log mode is not valid: ".. mode) end
    print(Lummander.colorizer[mode](text))
end

luc:commands_dir("commands"):parse(arg)

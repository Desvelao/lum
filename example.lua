package.path = 'C:/projects/lummander/?/init.lua;C:/projects/lummander/?.lua;' .. package.path
-- package.cpath = '?.dll;./?.dll;' .. package.cpath
local Lummander = require "lummander"
local pack = pack or table.pack

local commander = Lummander.new{
    title = 'lum CLI',
    tag = 'lum',
    root_path = 'C:/projects/lummander',
    flag_prevent_help = false,
    devmode = false
}
-- print(package.searchpath( "lummander", package.path ))

commander:commands_dir("example/commands"):parse(arg)

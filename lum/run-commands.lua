local join_string = function(...)
    local str = ""
    for k,v in pairs(args) do
        str = str .. " " .. v
    end
    return str
end

local echo = function(message) return join_string("echo","\"" ..message .. "\"") end
local add = function() return "git add -A" end
local commit = function(message) return "git commit -m \"" .. message .. "\"" end
local push = function(origen, branch) return "git push " .. origen .. " " .. branch end
local tag = function(version, message) return "git tag -a " .. version .. " -m \"" .. message .. "\"" end
local npminit = function(flag) return "npm init " .. ((flag and "-y") or " ") end
local gitinit = function() return "git init" end
local luarocksinit = function() return "luarocks init" end
local ldoc = function(dir) return "ldoc -d docs -f markdown ./" .. dir end
local cd = function(dir) return "cd " .. dir end
return {
    echo = echo,
    add = add,
    commit = commit,
    push = push,
    tag = tag,
    npminit = npminit,
    gitinit = gitinit,
    luarocksinit = luarocksinit,
    ldoc = ldoc,
    cd = cd
}
-- return {
--     echo = join_string(),
--     add = 'git add -A',
--     commit = 'git commit -m "%1"'
--     push = ' git push %1 %2'
--     pushmit = 'git add -A && git commit -m "%1" && git push origin master',
--     dir = 'dir',
--     ldoc = 'ldoc -d docs -f markdown ./%1'
-- }
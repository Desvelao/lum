local join_string = function(...)
    local str = ""
    for k,v in pairs(args) do
        str = str .. " " .. v
    end
    return str
end

local echo = function(message) return "echo \"" ..message .. "\"" end
local add = function() return "git add -A" end
local commit = function(message) return "git commit -m \"" .. message .. "\"" end
local push = function(origen, branch) return "git push " .. origen .. " " .. branch end
local tag = function(version, message) return "git tag -a " .. version .. " -m \"" .. message .. "\"" end
local npminit = function(flag) return "npm init " .. ((flag and "-y") or " ") end
local gitinit = function() return "git init" end
local gitbranch = function() return "git branch" end
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
    gitbranch = gitbranch,
    luarocksinit = luarocksinit,
    ldoc = ldoc,
    cd = cd
}
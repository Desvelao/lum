return {
    command = "project <enviorement> <name>",
    description = "Create a new project folder and init npm/git/luarocks. Env: nodejs, luarocks",
    alias = {"p", "new"},
    positional_args = {
        name = {
            description = "Project Name"
        },
        enviorement = "Enviorement: nodejs/luarocks"
    },
    action = function(parsed, command, lum)
        local npminit, gitinit = require('run-commands').npminit, require('run-commands').gitinit
        local luarocksinit, cd = require('run-commands').luarocksinit, require('run-commands').cd
        if parsed.enviorement == "nodejs" then
            lum.methods.mkdir("./"..parsed.name)
            lum:execute(cd(parsed.name) .. " && " .. npminit(true),print)
            lum:execute(cd(parsed.name) .. " && " .. gitinit(),print)
        elseif parsed.enviorement == "luarocks" then
            lum.methods.mkdir("./"..parsed.name)
            lum:execute(cd(parsed.name) .. " && " .. luarocksinit(),print)
            lum:execute(cd(parsed.name) .. " && " .. gitinit(),print)
        else
            print(lum.colorizer.yellow("Enviorements: ") .. "nodejs, luarocks")
        end
    end
}
return {
    command = "run <command>",
    description = "Run scripts commands like npm run. Require a lum_run.lua file in current directory",
    action = function(parsed, command, lum)
        local current_dir = lum.lfs.currentdir()
        package.path = current_dir.."/?.lua;"..package.path
        lum.pcall(function()
            local scripts = require("lum_run")
            lum:execute(scripts[parsed.command], print)
        end):fail(function(err)
            lum.colorizer.pred(err)
        end)
    end
}
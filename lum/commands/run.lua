return {
    command = "run [command]",
    description = "Run scripts commands like npm run. Require a lum_run.lua file in current directory",
    action = function(parsed, command, lum)
        local current_dir = lum.lfs.currentdir()
        package.path = current_dir.."/?.lua;"..package.path
        lum.pcall(function()
            return require("lum_run")
        end):pass(function (scripts)
            if(parsed.command and scripts[parsed.command]) then
                lum:execute(scripts[parsed.command], print)
            else
                lum.theme.primary("Scripts:")
                for k,v in pairs(scripts) do
                    lum.theme.secondary("  " ..k .. ": ".. v)
                end
            end
        end):fail(function(err)
            lum.theme.error("It didn't find lua_run.lua file")
        end)
    end
}
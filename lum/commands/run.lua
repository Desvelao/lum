return {
    command = "run [command]",
    positional_args = {
        command = {
            description = "Script to execute",
            default = "start"
        }
    },
    description = "Run scripts commands like npm run. Require a lum_run.lua file in current directory",
    action = function(parsed, command, lum)
        local current_dir = lum.lfs.currentdir()
        package.path = current_dir.."/?.lua;"..package.path
        lum.pcall(function()
            return require("lum_run")
        end):pass(function (scripts)
            if(parsed.command and scripts[parsed.command]) then
                local script = scripts[parsed.command]
                if(type(script) == "string") then
                    print(lum.chalk.yellow("> ".. lum.tag .. " run " .. parsed.command))
                    lum:execute(script, print)
                elseif(type(script) == "function") then
                    print(lum.chalk.yellow("> ".. lum.tag .. " run " .. parsed.command))
                    script(lum)
                end
            else
                lum.theme.primary("Scripts:")
                for k,v in pairs(scripts) do
                    lum.theme.secondary("  " ..k .. ": ".. tostring(v))
                end
            end
        end):fail(function(err)
            lum.theme.error("It didn't find lua_run.lua file. You can create one with `lum init`")
        end)
    end
}
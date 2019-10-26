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
        local original_path = package.path
        lum.pcall(function()   
            local scripts = {}

            lum.pcall(function() -- try to load local lum_run.lua
                package.path = current_dir.."/?.lua;" .. original_path
                return require("lum_run")
            end):pass(function(scp)
                scripts = scp
            end):done()

            lum.pcall(function() -- try to load home/<username>/.lum lum_run.lua
                package.path = lum.methods.lum_home() .. "/?.lua;" .. original_path
                return require("lum_run")
            end):pass(function(scp)
                for k,v in pairs(scp) do
                    if(not scripts[k]) then scripts[k] = v end
                end
            end):done()
            return scripts
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
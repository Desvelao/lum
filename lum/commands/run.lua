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
        local user_lum_dir = lum.methods.lum_home()
        local original_path = package.path
        local scripts = {}
        local function add_to_scripts(mode)
            return function(scp)
                for k,v in pairs(scp) do
                    if(scripts[k] == nil) then scripts[k] = {mode = mode or "", command = v} end
                end
            end
        end
        lum.pcall(function()   

            lum.pcall(function() -- try to load local lum_run.lua
                package.path = current_dir.."/?.lua;" .. original_path
                return require("lum_run")
            end):pass(add_to_scripts("[./]")):done()

            lum.pcall(function() -- try to load home/<username>/.lum lum_run.lua
                package.loaded["lum_run"] = nil -- unload from require chache the previous lu_run.lua file
                package.path = user_lum_dir .. "/?.lua;" .. original_path
                return require("lum_run")
            end):pass(add_to_scripts("[/.lum]")):done()
            local ftable = require("f.table")
            if(ftable.length(scripts) == 0) then error() end
            return scripts
        end):pass(function (scripts)
            if(parsed.command and scripts[parsed.command]) then
                local script = scripts[parsed.command].command
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
                    lum.theme.secondary("  " ..k .. ": " ..tostring(v.command) .. " "..(v.mode))
                end
            end
        end):fail(function(err)
            lum.theme.error("lua_run.lua file not found (in current directory or " .. user_lum_dir .."). Create one in current folder with `lum init`")
        end)
    end
}
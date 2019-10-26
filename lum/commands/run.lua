return {
    command = "run [command] [...args]",
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
        local somescript = false
        lum.pcall(function()   
            local scripts = {}
            local function add_to_scripts(mode)
                return function(scp)
                    for k,v in pairs(scp) do
                        if(scripts[k] == nil) then
                            scripts[k] = {mode = mode or ""}
                            if(type(v) == "string") then
                                scripts[k].description = v
                                scripts[k].run = function(app, args) lum:execute(v, print) end
                            elseif(type(v) == "function") then
                                scripts[k].description = ""
                                scripts[k].run = v
                            elseif(type(v) == "table") then
                                scripts[k].description = v.description or ""
                                if(type(v.run) == "string") then
                                    scripts[k].description = v.run
                                    scripts[k].run = function(app, args) lum:execute(v.run, print) end
                                elseif(type(v.run) == "function") then
                                    scripts[k].run = v.run
                                else
                                    error("Error loading lum_run.lua: .run should be a string or function")
                                end
                            end
                            somescript = true
                        end
                    end
                end
            end
            lum.pcall(function() -- try to load local lum_run.lua
                package.path = current_dir.."/?.lua;"
                return require("lum_run")
            end):pass(add_to_scripts("[./]")):done()

            lum.pcall(function() -- try to load home/<username>/.lum lum_run.lua
                package.loaded["lum_run"] = nil -- unload from require chache the previous lu_run.lua file
                package.path = user_lum_dir .. "/?.lua;"
                return require("lum_run")
            end):pass(add_to_scripts("[/.lum]")):done()

            if(not somescript) then error("lua_run.lua file not found (in current directory or " .. user_lum_dir .."). Create one in current folder with `lum init`\nOr there aren't scripts defined") end
            return scripts
        end):pass(function (scripts)
            package.path = original_path
            if(parsed.command and scripts[parsed.command]) then
                local script = scripts[parsed.command]
                print(lum.chalk.yellow("> ".. lum.tag .. " run " .. parsed.command))
                script.run(lum, parsed.args)
            else
                lum.theme.primary("Scripts:")
                for k,v in lum.methods.ordered_pairs(scripts) do
                    lum.theme.secondary("  " ..k .. ": " ..tostring(v.description) .. " "..(v.mode))
                end
            end
        end):fail(function(err)
            lum.theme.error(err)
        end)
    end
}
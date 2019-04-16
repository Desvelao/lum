return {
    schema = "alias <command_alias> <command>",
    description = "Create a command alias",
    options = {
        {short = "p", long = "path", description = "Set a path"},
        {short = "b", long = "bat", description = "Extension .bat (default .cmd)", type = "flag"},
    },
    action = function(parsed, command, lum)
        local default_dir = "C:/utils-path"
        local extension = ".cmd"
        if(parsed.bat) then extension = ".bat" end
        local pathfile = default_dir.. "/".. parsed.command_alias .. extension
        print(pathfile, parsed.command)
        local file = io.open(pathfile, "w")
        file:write(parsed.command)
        file:close()
        print("Alias created\nalias: " .. lum.colorizer.green(parsed.command_alias) .. "\npath: " .. lum.colorizer.green(pathfile) .. "\ncommand: " .. lum.colorizer.green(parsed.command))
    end
}
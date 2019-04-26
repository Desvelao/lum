return {
    command = "run <command> [args]",
    description = "Run command from luc_package.lua",
    options = {
        {short = "f", long = "file", description = "Year", default = "luc_package"}
    },
    action = function(parsed, command, lum)
        local dir = lum.lfs.currentdir()
        package.path = package.path .. lum.lfs.currentdir() .. "/?.lua"
        local config = require(parsed.file)
        local cmd = config[parsed.command]
        print(cmd)
        if(cmd) then
            lum:execute(cmd, print)
        else
            lum.print('error', 'Command not found on luc_package.lua')
        end
    end
}
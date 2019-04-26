return {
    command = "ldoc [dir]",
    description = "create lua docs",
    options = {
    },
    action = function(parsed, command, lum)
        local cmd = require("run-commands").ldoc
        cmd = cmd:gsub('%%1', parsed.dir or "")
        lum.theme.primary(command.description)
        lum.theme.primary('> '..cmd)
        -- return;
        lum:execute(cmd, print)
    end
}
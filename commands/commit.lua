return {
    command = "commit [message]",
    description = "Git add && commit",
    action = function(parsed, command, lum)
        parsed:print()
        local cmd = require('run-commands').commit
        local message = 'Commit using Lum'
        cmd = cmd:gsub('%%1', parsed.message or message)
        lum.theme.primary(command.description)
        lum.theme.primary('> '..cmd)
        lum:execute(cmd, print)
    end
}
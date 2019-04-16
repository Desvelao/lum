return {
    schema = "commit [message]",
    description = "Git add && commit",
    action = function(parsed, command, lum)
        parsed:print()
        local cmd = require('example.run-commands').commit
        local message = 'Commit using Lum'
        cmd = cmd:gsub('%%1', parsed.message or message)
        print(command.description)
        print('> '..cmd)
        -- os.execute(cmd)
        lum:execute(cmd, print)
    end
}
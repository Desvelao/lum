return {
    schema = 'pushmit [message]',
    description = 'Git add && commit && push',
    options = {
        {short = 'o', long = 'origin', description = 'Remote name', default = "origin"},
        {short = 'b', long = 'branch', description = 'Branch name', default = "master"}
    },
    action = function(parsed, command, lum)
        parsed:print()
        local cmd = require('example.run-commands').pushmit
        local origin, branch = 'origin', 'master'
        cmd = cmd:gsub('%%1', parsed.message or 'Commit using Luc')
        cmd = parsed.origin and cmd:gsub('origin', parsed.origin or origin) or cmd
        cmd = parsed.branch and cmd:gsub('master', parsed.branch or branch) or cmd
        print(command.description)
        print('> '..cmd)
        -- os.execute(cmd)
        lum:execute(cmd, print)
    end
}
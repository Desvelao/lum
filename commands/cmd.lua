return {
    schema = "cmd <command> [args]",
    description = "Run commands",
    action = function(parsed, command, lum)
        parsed:print()
        local commands = require('example.run-commands')
        local cmd = commands[parsed.command]
        if(cmd)then
            for i=3,#parsed do
                cmd = cmd:gsub('%%'..i-2, parsed[i])
            end
            lum.colorizer.pgreen('Execute cmd: '..cmd..'\n')
            -- os.execute(command)
            lum:execute(cmd, print)
        end
    end
}
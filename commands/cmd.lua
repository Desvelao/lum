return {
    command = "cmd [command] [args]",
    description = "Run commands",
    action = function(parsed, command, lum)
        local commands = require('run-commands')
        if(parsed.command and commands[parsed.command]) then
            local cmd = commands[parsed.command]
            if(cmd)then
                for i=3,#parsed do
                    cmd = cmd:gsub('%%'..i-2, parsed[i])
                end
                lum.theme.primary('Execute cmd: '..cmd..'\n')
                lum:execute(cmd, print)
            end
        else
            local result = lum.tag .. ' cmd <command> [args]\n'
            for k,v in pairs(commands) do
                result = result .. '  ' .. lum.theme.primary.color(k) .. ' => ' .. v .. '\n'
            end
            print(result)
        end
    end
}
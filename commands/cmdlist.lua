return {
    schema = "cmdlist",
    description = "List lum commands",
    action = function(parsed, command, lum)
        parsed:print()
        local commands = require('example.run-commands')
        local result = lum.tag .. ' cmd <command> [args]\n'
        for k,v in pairs(commands) do
            result = result .. '  ' .. lum.colorizer.green(k) .. ' => ' .. v .. '\n'
        end
        print(result)
    end
}
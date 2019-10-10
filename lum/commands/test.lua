return {
    command = "test [data] [...array]",
    description = "Create a command alias",
    alias = {"newc", "other-cmd"},
    positional_args = {
        data = {
            description= 'my desc',
            default= 'default val'
        }
    },
    hide = true,
    options = {
        {short = "p", long = "path", description = "Set a path", type = "flag", default=false},
        {short = "b", long = "bat", description = "Extension .bat (default .cmd)", type = "flag", default="data"},
    },
    action = function(parsed, command, lum)
        parsed:print()
        local chalk = require"chalk"
        print(chalk.style('red bgblue')('Hi'))
        -- parsed:print()
        -- parsed.array:for_each(function(value, index, array)
        --     lum.theme.cli.title("Array: "..value)
        -- end)
        -- error("my error")
        -- lum:execute("git branch")
        -- for k,v in pairs(command.arguments) do
        --     print(k,v.default)
        -- end
    end
}
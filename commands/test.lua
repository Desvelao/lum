return {
    command = "new <data> [...array]",
    description = "Create a command alias",
    alias = {"newc", "other-cmd"},
    default_args = {
        data = "my custom value"
    },
    hide = true,
    options = {
        {short = "p", long = "path", description = "Set a path", type = "flag", default=false},
        {short = "b", long = "bat", description = "Extension .bat (default .cmd)", type = "flag", default="data"},
    },
    action = function(parsed, command, lum)
        parsed:print()
        parsed.array:for_each(function(value, index, array)
            lum.theme.cli.title("Array: "..value)
        end)
        error("my error")
    end
}
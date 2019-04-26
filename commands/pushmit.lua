return {
    command = "pushmit [message]",
    description = "Git add && commit && push",
    default_args = {
        message = "Commit using Luc"
    },
    options = {
        {short = "o", long = "origin", description = "Remote name", default = "origin"},
        {short = "b", long = "branch", description = "Branch name", default = "master"}
    },
    action = function(parsed, command, lum)
        parsed:print()
        local cmd = require("run-commands").pushmit
        local origin, branch = "origin", "master"
        cmd = cmd:gsub("%%1", parsed.message or "Commit using Luc")
            :gsub("origin", parsed.origin)
            :gsub("master", parsed.branch)

        lum.theme.primary(command.description)
        lum.theme.primary("> "..cmd)
        lum:execute(cmd, print)
    end
}
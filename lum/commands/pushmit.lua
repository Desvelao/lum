return {
    command = "pushmit [message]",
    description = "Git add && commit && push",
    alias = {"apm", "acp"},
    positional_args = {
        message = {
            description = "Message to commit",
            default = "Commit using Luc"
        }
    },
    options = {
        {short = "o", long = "origin", description = "Remote name", default = "origin"},
        {short = "b", long = "branch", description = "Branch name", default = "master"}
    },
    action = function(parsed, command, lum)
        local add, commit, push = require('run-commands').add, require('run-commands').commit, require('run-commands').push
        lum:execute(add(), print)
        lum:execute(commit(parsed.message), print)
        lum:execute(push(parsed.origin, parsed.branch), print)
    end
}
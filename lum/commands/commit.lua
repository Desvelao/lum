return {
    command = "commit [message]",
    alias = {"ac", "c"},
    positional_args = {
        message = {
            description = "Message to commit",
            default = "Commit with lum"
        }
    },
    description = "Git add && commit",
    action = function(parsed, command, lum)
        local add, commit = require('run-commands').add, require('run-commands').commit
        lum:execute(add(), print)
        lum:execute(commit(parsed.message), print)
    end
}
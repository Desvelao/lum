return {
    command = "push [message]",
    description = "Git add && commit && push",
    alias = {"acp", "p"},
    positional_args = {
        message = {
            description = "Message to commit",
            default = "Commit using Lum"
        }
    },
    options = {
        {short = "o", long = "origin", description = "Remote name", default = "origin"},
        {short = "b", long = "branch", description = "Branch name", default = "master"}
    },
    action = function(parsed, command, lum)
        local add, commit, push, currentgitbranch = require('run-commands').add, require('run-commands').commit, require('run-commands').push, require('run-commands').currentgitbranch
        lum.pcall(function()
            lum:execute(add(), print)
            lum:execute(commit(parsed.message), print)
            parsed.branch = lum:execute_silent(currentgitbranch()):gsub("* ", "")
            lum:execute(push(parsed.origin, parsed.branch), print)
        end):fail(function(err)
            lum.theme.error('A error ocurred:\n'..err)
        end)
    end
}
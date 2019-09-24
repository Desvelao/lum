return {
    command = "release <tag>",
    description = "Create a git tag and push to remote",
    alias = {"r"},
    positional_args = {
        tag = "Release tag"
    },
    options = {
        {short = "m", long = "message", description = "Set a message for the release", default = ""},
        {short = "r", long = "remote", description = "Remote origin", default = "origin"},
    },
    action = function(parsed, command, lum)
        local tag, push = require('run-commands').tag, require('run-commands').push
        lum:execute(tag(parsed.tag, parsed.message), print)
        lum:execute(commit(parsed.message), print)
        lum:execute(push(parsed.remote, parsed.tag), print)
    end
}
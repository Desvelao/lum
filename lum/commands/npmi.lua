return {
    command = "npminit",
    alias = {"ni"},
    description = "NPM and Git init",
    options = {
        {short = "g", long = "git", description = "git init", type = "flag"}
    },
    action = function(parsed, command, lum)
        local npminit, gitinit = require('run-commands').npminit, require('run-commands').gitinit
        lum:execute(npminit(true), print)
        if(parsed.git)then lum:execute(gitinit(), print) end
    end
}

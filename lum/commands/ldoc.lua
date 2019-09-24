return {
    command = "ldoc [dir]",
    description = "Create lua docs",
    positional_args = {
        dir = "Directory"
    },
    options = {
    },
    action = function(parsed, command, lum)
        local ldoc = require('run-commands').ldoc
        lum:execute(ldoc(), print)
    end
}
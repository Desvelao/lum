return {
    command = "ldoc [dir]",
    description = "Create lua docs",
    positional_args = {
        dir = {
            description = "Directory",
            default = ""
        }
    },
    action = function(parsed, command, lum)
        local ldoc = require('run-commands').ldoc
        lum:execute(ldoc(parsed.dir), print)
    end
}
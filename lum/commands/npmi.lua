return {
    command = "ni",
    description = "NPM and Git init",
    options = {
        -- {short = "y", long = "yes", description = "Create a package.json", type = "flag"},
        {short = "g", long = "git", description = "git init", type = "flag"}
    },
    action = function(parsed, command, lum)
        local sufix = ""
        -- if(parsed.yes)then sufix = " -y" end
        lum:execute("npm init -y"..sufix, print)
        if(parsed.git)then lum:execute('git init', print) end
    end
}

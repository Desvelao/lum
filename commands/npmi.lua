return {
    schema = "ni",
    description = "NPM init",
    options = {
        {short = "y", long = "yes", description = "Create a package.json", type = "flag"},
        {short = "g", long = "git", description = "git init", type = "flag"}
    },
    action = function(parsed, command, lum)
        parsed:print()
        local sufix = ""
        if(parsed.yes)then sufix = " -y" end
        -- os.execute("npm init"..sufix)
        lum:execute("npm init"..sufix, print)
        if(parsed.git)then lum:execute('git init', print) end
    end
}

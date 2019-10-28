return {
    command = "--update",
    description = "Download last lum version",
    action = function(parsed, command, lum)
        lum.pcall(function()
            lum:execute("sudo sh " .. lum_path .. "/install.sh update " .. lum.version, print)
        end):fail(function(err)
            lum.theme.error("Error updating lum")
        end)
    end
}

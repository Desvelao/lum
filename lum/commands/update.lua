return {
    command = "update",
    description = "Download last lum version",
    options = {
        {short = "f", long = "force", description = "Force download", default = false}
    },
    action = function(parsed, command, lum)
        lum.pcall(function()
            lum:execute("sudo sh " .. lum_path .. " update")
            -- lum:execute('sudo sh -c "$(curl https://raw.githubusercontent.com/desvelao/lum/master/install.sh)"', print)
            -- lum.theme.success("Updated lum to last version!")
        end):fail(function(err)
            lum.theme.error("Error updating lum")
        end)
    end
}

local util = require("lummander.utils")

function showLicenses(lum)
    local licenses = {'mit', 'apache2'}
    lum.theme.cli.text('Licenses avaliables: '.. util.table.join(licenses, ', '))
end

return {
    command = "license [lcs]",
    description = "Create a license file",
    positional_args = {
        lcs = "Type license: mit, apache2"
    },
    options = {
        {short = "y", long = "year", description = "Year"},
        {short = "o", long = "owner", description = "Owner name"},
    },
    action = function(parsed, command, lum)
        local dir = lum.lfs.currentdir()
        if(parsed.lcs)then
            lum.pcall(function()
                local req, _r = require("license/" .. parsed.lcs)
                local year = os.date("%Y")
                local text = req:gsub("%[year%]", parsed.year or year):gsub("%[ownername%]", parsed.owner or "[ownername]")
                lum.pcall(function()
                    local f = io.open("LICENSE.md", "w")
                    if(not f)then return end
                    f:write(text)
                    f:close()
                    lum.theme.success("Saved license " .. parsed.lcs .. " on LICENSE.md!\nYear: " .. (parsed.year or "unset") .. "\nOwner: " ..(parsed.owner or "unset"))
                end):fail(function(err)
                    lum.theme.error("Error ocurred saving LICENSE.md\n"..err)
                end)
            end):fail(function(err)
                showLicenses(lum)
            end)
        else
            showLicenses(lum)
        end
    end
}
return {
    command = "init",
    description = "Create a lum_run.lua file",
    action = function(parsed, command, lum)
        lum.pcall(function()
            local f = io.open("lum_run.lua", "w")
        if(not f)then return end
        f:write([[return {
            -- add more scripts to run with `lum run <script_name>`
            test = "ldoc ."
        }]])
        f:close()
        lum.theme.success("Saved lum_run.lua!")
        end):fail(function(err)
            lum.theme.error("Ocurred an error")
        end)
    end
}

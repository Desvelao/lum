return {
    command = "time",
    description = "Show the time",
    action = function(parsed, cmd, lum)        
        lum.colorizer.pyellow(os.date("Time is: %I:%M:%S"))
    end
}
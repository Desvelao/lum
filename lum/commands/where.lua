return {
    command = "where",
    description = "Where is lum installed",
    action = function(parsed, command, lum)
        print('lum src is installed on: /usr/share/lum')
        print('lum executable is installed on: /usr/bin/lum')
    end
}
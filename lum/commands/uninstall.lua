return {
    command = "uninstall",
    description = "Uninstall lum",
    action = function(parsed, command, lum)
        lum:execute('sudo sh /usr/share/lum/uninstall.sh', print)
        print('lum was successfully uninstalled')
    end
}
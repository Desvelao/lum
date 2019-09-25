return {
    command = "uninstall",
    description = "Unistall lum",
    action = function(parsed, command, lum)
        lum:execute('su /usr/share/lum/uninstall.sh', print)
        print('lum was successfully uninstalled')
    end
}
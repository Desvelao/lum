return {
    command = "--about",
    description = "Info about lum",
    action = function(parsed, command, lum)
        print("lum is: " .. lum.description)
        print('lum src: /usr/share/lum')
        print('lum executable: /usr/bin/lum')
        print('repository: https://github.com/Desvelao/lum')
    end
}
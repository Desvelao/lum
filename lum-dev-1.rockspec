package = "lum"
version = "dev-1"
source = {
   url = "git://github.com/Desvelao/lum",
   tag = "dev0.1"
}
description = {
   homepage = "https://github.com/Desvelao/lum",
   license = "*** please specify a license ***"
}
dependencies = {
   
}
build = {
   type = "builtin",
   modules = {
      ["lum.commands.alias"] = "lum/commands/alias.lua",
      ["lum.commands.cmd"] = "lum/commands/cmd.lua",
      ["lum.commands.commit"] = "lum/commands/commit.lua",
      ["lum.commands.ldoc"] = "lum/commands/ldoc.lua",
      ["lum.commands.license"] = "lum/commands/license.lua",
      ["lum.commands.npmi"] = "lum/commands/npmi.lua",
      ["lum.commands.pushmit"] = "lum/commands/pushmit.lua",
      ["lum.commands.run"] = "lum/commands/run.lua",
      ["lum.commands.test"] = "lum/commands/test.lua",
      ["lum.commands.time"] = "lum/commands/time.lua",
      ["lum.license.apache2"] = "lum/license/apache2.lua",
      ["lum.license.mit"] = "lum/license/mit.lua",
      ["lum.lum"] = "lum/lum.lua",
      ["lum.lum_package"] = "lum/lum_package.lua",
      ["lum.run-commands"] = "lum/run-commands.lua"
   },
   install = {
    bin = { ["lum"] = "lum/lum.lua", },
  }
}

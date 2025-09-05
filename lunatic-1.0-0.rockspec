package = "Lunatic"
version = "1.0-0"
source = {
  url = "git://github.com/mrc6/Lunatic_a_Lua_Test_Framework.git"
}
description = {
  summary = "Lua Test Framework",
  detailed = [[
Lua Test Framework for automation (Unity, Web, Desktop, ALL)
  ]],
  homepage = "https://mrc6.github.io/marcobarbosa.github.io",
  maintainer = "Marco Barbosa <marco.meireles.b@gmail.com>",
  license = "MIT"
}
dependencies = {
  "lua >= 5.1",
  "luasocket >= 2.0",
  "dkjson >= 2.8-1"
}
build = {
  type = "builtin",
  modules = {
    framework = "lib/lunatic.lua",
    append_row = "lib/append_row_at_file.lua",
    webdriver  = "lib/luawebdriver.lua",
    tableutils = "lib/tableUtils.lua"
  }
}

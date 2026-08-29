--package.path = package.path .. ";/root/my-documents/temp/Lua/Lunatic/Lunatic_a_Lua_Test_Framework/examples/?.lua"
--local pwd = require('pwd')
local config = {
    browser_webdriver_path = "../drivers", --All paths are relative to the conf folder of the project, so this path is relative to the conf folder of the project
    browser_webdriver_executable = "geckodriver"
}

return config
--dependencies: lua selenium. How to install: luarocks install luaselenium

--loading the framework
local describe = require('lunatic')

local setup = {
  get_connection = function ()
    -- This example opens the Edge (or Firefox) browser by creating a new session and then goes to google.com
    -- After that it gets the PDF print for the page. The PDF data is written to the file test.pdf

    PORT = 4444	-- This is the port where the webdriver server is listening. This should be changed if it is listening at another port. When the webdriver executable is run then it shows the port number

    wd = require("luawebdriver")
    conn = wd.new(PORT,"firefox")
    return conn
  end
}

local conn = setup.get_connection()

--runnint set of tests
describe('Test function', function ()
  it('This is a passing test', function ()
    local stat,msg = conn:gotoURL({ body = { url = "http://google.com"} })  
    local expected_name = "I am a string"
    local obtained_name = "I am a string" --do some action that results the expected string
    local failure_comment = "Expected name was "..expected_name..", but is "..obtained_name
    assert(obtained_name == expected_name, failure_comment)
  end)
  it('This is a failing test', function ()
    local stat,msg = conn:gotoURL({ body = { url = "http://google.com"} }) 
    local expected_name = "I am a string"
    local obtained_name = "I am a number" --do some action that results the expected string
    local failure_comment = "Expected name was "..expected_name..", but is "..obtained_name
    assert(obtained_name == expected_name, failure_comment)
  end)
end)

local tear_down = {
  close = function (conn)
    conn:delete()
  end
}

tear_down.close(conn)

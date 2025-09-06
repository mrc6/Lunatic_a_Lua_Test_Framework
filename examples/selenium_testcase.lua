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

-- Using os.time() for seconds
os = require("os")
function wait(seconds)
  local start_time = os.time()
    repeat until os.time() > start_time + seconds
end

local conn = setup.get_connection()

--runnint set of tests
describe('Test function', function ()
  it('The best programming language', function ()
    local stat,msg = conn:gotoURL({ body = { url = "http://google.com"} })

    -- below an example of find_element method to be implemented (by you!)
    local element = conn:findElement({ body = { using = "tag name", value = "textarea" } }).value
    element_properties = {}
    for chave, valor in pairs(element) do
      table.insert(element_properties,valor)
    end
    element_id = element_properties[1]

    -- sending keys to element
    conn:elementSendKeys({ body = { elementId = element_id, text = "Lua Programming Language" } })
    
    wait(5)
  end)
  it('Check Gmail Page Title', function ()
    local stat,msg = conn:gotoURL({ body = { url = "http://google.com"} }) 
    local expected_title = "Gmail: Private and secure email at no cost | Google Workspace"
    local obtained_title = "Default String" --do some action that results the expected string
    
    
    -- clicking in the first link
    local element = conn:findElement({ body = { using = "xpath", value = "//a/parent::*" } }).value
    element_properties = {}
    for chave, valor in pairs(element) do
      table.insert(element_properties,valor)
    end
    element_id = element_properties[1]
    
    element_text = conn:getElementText({ elementId = element_id}).value --should be Gmail link
    wait(5)--needs improvement for dynamic wait
    
    conn:elementClick({ body = { elementId = element_id } })
    wait(5) --needs improvement for dynamic wait
    
    print(conn:getTitle().value)
    obtained_title = conn:getTitle().value
    
    local failure_comment = "Expected name was "..expected_title..", but is "..obtained_title
    assert(obtained_name == expected_name, failure_comment)
  end)
end)

local tear_down = {
  close = function (conn)
    conn:delete()
  end
}

tear_down.close(conn)

--loading the framework
local describe = require('lunatic')
local selenium_webdriver = require('selenium_webdriver')

-- Using os.time() for seconds
os = require("os")
function wait(seconds)
  local start_time = os.time()
    repeat until os.time() > start_time + seconds
end

--local conn = setup.get_connection()
local conn = selenium_webdriver.get_connection()
--runnint set of tests
describe('Test function', function ()
  it('The best programming language', function ()
    local stat,msg = selenium_webdriver.navigate(conn, "http://google.com")
    element_id = selenium_webdriver.find_element_by_tagname(conn, "textarea")

    -- sending keys to element
    selenium_webdriver.send_keys(conn, element_id, "Lua Programming Language")
    wait(5)
  end)
  it('Check Gmail Page Title', function ()
    local stat,msg = selenium_webdriver.navigate(conn, "http://google.com")
    local expected_title = "Gmail: Private and secure email at no cost | Google Workspace"
    local obtained_title = "Default String" --do some action that results the expected string
    
    
    -- clicking in the first link  
    element_id = selenium_webdriver.find_element_by_xpath(conn, "//a/parent::*")
    
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

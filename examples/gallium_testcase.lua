--loading the framework
local describe = require('lunatic')
local gallium_webdriver = require('gallium_webdriver') --used to test the new version of the gallium_webdriver module

--loading the pwd module to get the absolute path of the file
local pwd = require('pwd')

-- Using os.time() for seconds
os = require("os")
function wait(seconds)
  local start_time = os.time()
    repeat until os.time() > start_time + seconds
end

local conn = gallium_webdriver.get_connection()

--runnint set of tests
describe('Test function', function ()
  it('The best programming language', function ()
    local obtained_title = "Default String" --do some action that results the expected string
    local expected_title = "Lua Programming Language"

    local stat,msg = gallium_webdriver.navigate(conn, "http://google.com")
    element_id = gallium_webdriver.find_element_by_tagname(conn, "textarea")

    -- sending keys to element
    gallium_webdriver.send_keys(conn, element_id, "Lua Programming Language")
    wait(5)
    
    -- make the search
    element_id = gallium_webdriver.find_element_by_xpath(conn, "//input[@name='btnK']")
    gallium_webdriver.element_click(conn, element_id)
    wait(5)
    
    obtained_title = gallium_webdriver.get_title(conn)
    wait(5) --needs improvement for dynamic wait
    --print(obtained_title)
    
    local failure_comment = "Expected title was "..expected_title..", but is "..obtained_title
    local is_substring = string.find(obtained_title, expected_title)

    assert(is_substring ~= nil, failure_comment)
  end)
  it('Check Gmail Page Title', function ()
    local stat,msg = gallium_webdriver.navigate(conn, "http://google.com")
    local expected_title = "Gmail: Private and secure email at no cost | Google Workspace"
    local obtained_title = "Default String" --do some action that results the expected string

    -- clicking in the first link  
    element_id = gallium_webdriver.find_element_by_xpath(conn, "//a/parent::*")
    
    element_text = gallium_webdriver.element_get_text(conn, element_id) --should be Gmail link
    wait(5)--needs improvement for dynamic wait
    
    gallium_webdriver.element_click(conn, element_id)
    wait(5) --needs improvement for dynamic wait
    
    obtained_title = gallium_webdriver.get_title(conn)
    wait(5) --needs improvement for dynamic wait
    print(obtained_title)
    
    local failure_comment = "Expected name was "..expected_title..", but is "..obtained_title
    assert(obtained_name == expected_name, failure_comment)
  end)
end)

--runnint set of tests
describe('Test local CAC TAT page', function ()
  it('Check CAC TAT page title', function ()
    local obtained_title = "Default String" --do some action that results the expected string
    local expected_title = "Central de Atendimento ao Cliente TAT"

    local local_url = pwd.abs_path("./src/index.html")
    local stat,msg = gallium_webdriver.navigate(conn, "file://" .. local_url)
  
    obtained_title = gallium_webdriver.get_title(conn)
    wait(5) --needs improvement for dynamic wait
    --print(obtained_title)
    
    local failure_comment = "Expected title was "..expected_title..", but is "..obtained_title
    local is_substring = string.find(obtained_title, expected_title)

    assert(is_substring ~= nil, failure_comment)
  end)
  it('Fill required fields and submit form', function()
      
    local local_url = pwd.abs_path("./src/index.html")
    local stat,msg = gallium_webdriver.navigate(conn, "file://" .. local_url)
    
    -- Filling the required fields
    local first_name = "João"
    local last_name = "da Silva"
    local email = "joao.silva@example.com"
    local text_area = "Arrume-me uma vaga QA remoto ganhando em Dólares"
    local expected_success_message = "Mensagem enviada com sucesso."
        
    local element_id = gallium_webdriver.find_element_by_id(conn, "firstName")
    gallium_webdriver.send_keys(conn, element_id, first_name)
    wait(1)

    element_id = gallium_webdriver.find_element_by_id(conn, "lastName")
    gallium_webdriver.send_keys(conn, element_id, last_name)
    wait(1)

    element_id = gallium_webdriver.find_element_by_id(conn, "email")
    gallium_webdriver.send_keys(conn, element_id, email)
    wait(1)

    element_id = gallium_webdriver.find_element_by_id(conn, "open-text-area")
    gallium_webdriver.send_keys(conn, element_id, text_area)
    wait(1)

    -- Submitting the form
    element_id = gallium_webdriver.find_element_by_xpath(conn, "//button[@type='submit']")
    gallium_webdriver.element_click(conn, element_id)
    wait(1)
    
    element_id = gallium_webdriver.find_element_by_class_name(conn, "success")
    
    local failure_comment = "Expected that element was displayed, but not "
    assert(gallium_webdriver.is_element_displayed(conn, element_id), failure_comment)
    
    local received_success_message = gallium_webdriver.get_element_text(conn, element_id)
    local failure_comment = "Expected success message was "..expected_success_message..", but is "..received_success_message
    assert(received_success_message == expected_success_message, failure_comment)

    wait(5)
    local failure_comment = "Expected that element was not displayed, but it was "
    assert(not gallium_webdriver.is_element_displayed(conn, element_id), failure_comment)
  end)
end)

local tear_down = {
  close = function (conn)
    conn:delete()
  end
}

tear_down.close(conn)

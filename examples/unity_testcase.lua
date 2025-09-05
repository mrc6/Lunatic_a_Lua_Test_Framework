--loading the framework
local describe = require('lunatic')

--runnint set of tests
describe('Test function', function ()
  it('This is a passing test', function ()  
    local expected_name = "I am a string"
    local obtained_name = "I am a string" --do some action that results the expected string
    local failure_comment = "Expected name was "..expected_name..", but is "..obtained_name
    assert(obtained_name == expected_name, failure_comment)
  end)
  it('This is a failing test', function ()  
    local expected_name = "I am a string"
    local obtained_name = "I am a number" --do some action that results the expected string
    local failure_comment = "Expected name was "..expected_name..", but is "..obtained_name
    assert(obtained_name == expected_name, failure_comment)
  end)
end)

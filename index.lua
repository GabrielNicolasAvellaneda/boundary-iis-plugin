local boundary = require('boundary')
local Emitter = require('core').Emitter
local Error = require('core').Error
local Object = require('core').Object
local Process = require('uv').Process
local timer = require('timer')
local math = require('math')
local string = require('string')
local os = require('os')
local CommandPlugin = require('framework').CommandPlugin

local params = boundary.param
params.name = 'Boundary IIS Plugin'
params.version = '1.0'
params.command = { cmd = 'echo', args = "'\\\\computador\\memória\\% bytes confirmados em uso : 81.4447516446157'"}

plugin = CommandPlugin:new(boundary.param)

--plugin:on('before_poll', function() p('before_poll') end)
--plugin:on('after_poll', function() p('after_poll') end)
function plugin:onParseCommandOutput(output)
	local result = {}

	result['IIS_CPU_USAGE'] = '123.45'

	return result
end

plugin:poll()


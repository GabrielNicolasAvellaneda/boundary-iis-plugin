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
	result['IIS_GENERAL_CPU_USAGE'] = '123.45'
	result['IIS_GENERAL_MEMORY_FREE'] = '123.45'
	result['IIS_GENERAL_MEMORY_PAGE_PER_SECOND'] = '123.45'
	result['IIS_GENERAL_DISK_TIME'] = '123.45'
	result['IIS_GENERAL_DISK_TIME'] = '123.45'
	result['IIS_ASPNET_REQUESTS_PER_SECOND'] = '1234.45'
	result['IIS_ASPNET_RESTARTS'] = '123.45'
	result['IIS_ASPNET_REQUEST_WAIT_TIME'] = '123.45'
	result['IIS_ASPNET_REQUESTS_QUEUED'] = '123.45'
	result['IIS_ASPNET_EXECPTIONS_THROWN_PER_SECOND'] = '123.45'
	result['IIS_ASPNET_TOTAL_COMMITTED_BYTES'] = '123.45'
	result['IIS_SERVICE_GET_REQUESTS_PER_SECOND'] = '123.45'
	result['IIS_SERVICE_POST_REQUESTS_PER_SECOND'] = '123.45'
	result['IIS_SERVICE_CURRENT_CONNECTIONS'] = '123.45'

	return result

end

plugin:poll()


-- [boundary.com] IIS Plugin using performance counters
-- [author] Gabriel Nicolas Avellaneda <avellaneda.gabriel@gmail.com>

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
local table = require('table')

local params = boundary.param
params.name = 'Boundary IIS Plugin'
params.version = '1.0'
params.command = { cmd = 'cat', args = "test\\lines.txt"}

plugin = CommandPlugin:new(boundary.param)

--plugin:on('before_poll', function() p('before_poll') end)
--plugin:on('after_poll', function() p('after_poll') end)


local pfMap = {}

function splitLines(str)

	local lines = str:split('\n')

	return lines
end

function parsePerformanceCounterLine(line)
	local parts = line:split(' : ')
	if (#parts ~= 2) then
		return nil
	end
	
	return parts[1], tonumber(parts[2])
end

local _map = {
	{metric = 'IIS_GENERAL_CPU_USAGE', perfCounterIdString = '', perfCounterLocalname = '\\\\computador\\memória\\% bytes confirmados em uso'},
	{metric = 'IIS_GENERAL_MEMORY_FREE', perfCounterIdString = '', perfCounterLocalname = ''},
	{metric = 'IIS_GENERAL_MEMORY_PAGE_PER_SECOND', perfCounterIdString = '', perfCounterLocalname = ''},
	{metric = 'IIS_GENERAL_DISK_TIME', perfCounterIdString = '', perfCounterLocalname = ''},
	{metric = 'IIS_ASPNET_REQUESTS_PER_SECOND', perfCounterIdString = '', perfCounterLocalname = ''},
	{metric = 'IIS_ASPNET_RESTARTS', perfCounterIdString = '', perfCounterLocalname = ''},
	{metric = 'IIS_ASPNET_REQUEST_WAIT_TIME', perfCounterIdString = '', perfCounterLocalname = ''},
	{metric = 'IIS_ASPNET_REQUESTS_QUEUED', perfCounterIdString = '', perfCounterLocalname = ''},
	{metric = 'IIS_ASPNET_EXECPTIONS_THROWN_PER_SECOND', perfCounterIdString = '', perfCounterLocalname = ''},
	{metric = 'IIS_ASPNET_TOTAL_COMMITTED_BYTES', perfCounterIdString = '', perfCounterLocalname = ''},
	{metric = 'IIS_SERVICE_GET_REQUESTS_PER_SECOND', perfCounterIdString = '', perfCounterLocalname = ''},
	{metric = 'IIS_SERVICE_POST_REQUESTS_PER_SECOND', perfCounterIdString = '', perfCounterLocalname = ''},
	{metric = 'IIS_SERVICE_CURRENT_CONNECTIONS', perfCounterIdString = '', perfCounterLocalname = ''}
}

function performanceCounterToMetric(performanceCounter, map)

	for k,v in pairs(map) do
		if v.perfCounterLocalname == performanceCounter then
			return v.metric
		end
	end

	return nil
end

function plugin:onParseCommandOutput(output)

	local lines = splitLines(output)
	local result = {}
	table.foreach(lines, 
		function (_, l)

			local line = l:trim()
			if (line:isEmpty()) then
				return
			end
			--print(line)

			local pc, val = parsePerformanceCounterLine(l)

			local metric = performanceCounterToMetric(pc, _map)
			if metric then
				result[metric] = val
			end

		end)
	
	return result

end

plugin:poll()


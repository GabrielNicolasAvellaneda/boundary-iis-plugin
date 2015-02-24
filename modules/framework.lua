local boundary = require('boundary')
local Emitter = require('core').Emitter
local Error = require('core').Error
local Object = require('core').Object
local Process = require('uv').Process
local timer = require('timer')
local math = require('math')
local string = require('string')
local os = require('os')

local framework = {}

local Plugin = Emitter:extend()
framework.Plugin = Plugin

function Plugin:initialize(params)
	self.pollInterval = 1000
	self.source = os.hostname()
	self.minValue = 0
	self.maxValue = 10

	if params ~= nil then
		self.pollInterval = params.pollInterval or self.pollInterval
		self.source = params.source or self.source
		self.minValue = params.minValue or self.minValue
		self.maxvalue = params.maxValue or self.minValue
	end

	print("_bevent:Boundary LUA Sample plugin up : version 1.0|t:info|tags:lua,plugin")
end

function Plugin:poll()
	
	self:emit('before_poll')

	local metrics = self:getMetrics()

	self:report(metrics)
	
	self:emit('after_poll')
	timer.setTimeout(self.pollInterval, function () self.poll(self) end)
end

function Plugin:report(metrics)
	self:emit('report')
	self:onReport(metrics)
end

function currentTimestamp()
	return os.time()
end

function Plugin:onReport(metrics)
	for metric, value in pairs(metrics) do
		print(self:format(metric, value, self.source, currentTimestamp()))
	end
end

function Plugin:format(metric, value, source, timestamp)
	self:emit('format')
	return self:onFormat(metric, value, source, timestamp) 
end

function Plugin:onFormat(metric, value, source, timestamp)
	return string.format('%s %f %s %s', metric, value, source, timestamp)
end

function Plugin:onGetMetrics()
	local value = math.random(self.minValue, self.maxValue)
	return {BOUNDARY_LUA_SAMPLE = value}
end

function Plugin:getMetrics()
    local metrics = self:onGetMetrics()	

	return metrics
end

return framework

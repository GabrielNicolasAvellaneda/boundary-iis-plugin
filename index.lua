local boundary = require('boundary')
local Emitter = require('core').Emitter
local Error = require('core').Error
local Object = require('core').Object
local Process = require('uv').Process
local timer = require('timer')
local math = require('math')
local string = require('string')
local os = require('os')
local Plugin = require('framework').Plugin

plugin = Plugin:new(boundary.param)

--plugin:on('before_poll', function() p('before_poll') end)
--plugin:on('after_poll', function() p('after_poll') end)

plugin:poll()


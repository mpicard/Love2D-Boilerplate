--
-- Game State
--

Game = {}

require(LIBPATH .. "middleclass")
local Map = require "src.maps.level1"
local updateRadius = 100
local camera, map
local Phi = 0.61803398875
local drawDebug = false

function Game:enter()
	local width, height = 1024, 480
	camera = gamera.new(0,0, width, height)
	map = Map:new(width, height, camera)
end

function Game:update(dt)
	local l,t,w,h = camera:getVisible()
	l,t,w,h = l - updateRadius, t - updateRadius, w + updateRadius * 2, h + updateRadius * 2
	map:update(dt, l,t,w,h)
	camera:setPosition(map.player:getCenter())
end

function Game:draw()
	camera:draw(function(l,t,w,h)
		map:draw(drawDebug, l,t,w,h)
	end)

end

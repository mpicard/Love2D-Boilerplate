-- Game State

-- Require important libs
local timer = require(LIBPATH .. "hump.timer")

-- Create new gamestate
Game = {}

-- Initialize stage
function Game:enter()
	pl = Player.create()
end

-- Stage/Level logic
function Game:update(dt)
	pl:update(dt)
end

-- Rendering
function Game:draw()
	-- Draw player
	pl:draw()

	-- Call debugging tools is set to true
	if isDebug == true then
		debugAll()
	end
end

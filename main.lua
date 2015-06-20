-- Main Lua

-- Call required libs
require("player")
require("sometext")

function love.load()
	-- Create the player
	pl = Player.create()
end

function love.update(dt)
	-- Update the player using it's own update method
	pl:update(dt)
end

function love.draw()
	-- Call debug functions
	printStatus()
	printFPS()

	-- Draw player
	pl:draw()
end

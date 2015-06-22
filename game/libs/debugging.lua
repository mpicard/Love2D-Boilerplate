-- Some debug functions
local debugText = "Called printStatus() function on debugging.lua!"

function printStatus()
	love.graphics.print(debugText, 10, 10)
end

function printFPS()
	love.graphics.print("FPS: " .. love.timer.getFPS(), 10, 30)
end

function printOS()
	love.graphics.print("OS: " .. love.system.getOS(), 10, 50)
end

function getPlayerX()
	love.graphics.print("xPos: " .. pl.x, 10, 70)
end

function getPlayerY()
	love.graphics.print("yPos: " .. pl.y, 10, 90)
end

function debugAll()
	printStatus()
	printFPS()
	printOS()
	getPlayerX()
	getPlayerY()
end

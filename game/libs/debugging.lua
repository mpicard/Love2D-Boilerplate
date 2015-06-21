-- Some debug functions
TEXT = "Called printStatus() function on sometext.lua!"

function printStatus()
	love.graphics.print(TEXT, 10, 10)
end

function printFPS()
	love.graphics.print("FPS: " .. love.timer.getFPS(), 10, 30)
end

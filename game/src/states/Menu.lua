-- Create Menu State
Menu = {}

-- Get window width and height
local H, W = love.graphics.getHeight(), love.graphics.getWidth()

-- Custom variables
local bgColor = { 0, 0, 0 }

-- Initialize before start
function Menu:init()
	-- Set background color
	love.graphics.setBackgroundColor(bgColor)

	-- Create buttons
	newGame 	= UI.Button( (W / 3) - 20, H / 2 + 50, 300, 50, 			{ extensions = { DefaultTheme.Button }, draggable = false })
	loadGame 	= UI.Button( (W / 3) - 20, newGame.y + 80, 300, 50, 	{ extensions = { DefaultTheme.Button }, draggable = false })
	options 	= UI.Button( (W / 3) - 20, newGame.y + 160, 300, 50, 	{ extensions = { DefaultTheme.Button }, draggable = false })
end

-- Main Menu Logic
function Menu:update(dt)
	newGame:update(dt)
	loadGame:update(dt)
	options:update(dt)

	-- Keybinds
	if newGame.released and newGame.hot then
		return Gamestate.switch(Game)
	end

	if loadGame.released and loadGame.hot then
		return Gamestate.switch(Game)
	end

	if options.released and options.hot then
		return Gamestate.switch(Game)
	end

	if love.keyboard.isDown('escape') then
		love.event.push('quit')
	end
end

-- Render buttons and text
function Menu:draw()
	newGame:draw()
	love.graphics.setColor( 255, 255, 255 )
	love.graphics.print( "NEW GAME", newGame.x + 115, newGame.y + 15 )

	loadGame:draw()
	love.graphics.setColor( 255, 255, 255 )
	love.graphics.print( "LOAD GAME", loadGame.x + 115, loadGame.y + 15 )

	options:draw()
	love.graphics.setColor( 255, 255, 255 )
	love.graphics.print( "OPTIONS", options.x + 125, options.y + 15 )
end

-- TODO: Find a better way to set text into the buttons.

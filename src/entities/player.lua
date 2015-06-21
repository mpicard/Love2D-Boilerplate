-- Player File

-- Attempting to put every aspect of the player here and let
-- it load in the main file.

Player = {}
Player.__index = Player
playerImg = love.graphics.newImage("gfx/player.png")

-- Function to create the player
function Player.create()
	local self = {}
	setmetatable(self,Player)
	self:reset()
	return self
end

-- Refresh the player on creation
function Player:reset()
	self.x = love.graphics.getWidth() / 2
	self.y = love.graphics.getHeight() / 2
	self.speed = 250
end

-- Player keybinds
function Player:update(dt)
	if love.keyboard.isDown("left") then
		self.x = self.x - (self.speed * dt)
	elseif love.keyboard.isDown("right") then
		self.x = self.x + (self.speed * dt)
	elseif love.keyboard.isDown("up") then
		self.y = self.y - (self.speed * dt)
	elseif love.keyboard.isDown("down") then
		self.y = self.y + (self.speed * dt)
	elseif love.keyboard.isDown("escape") then
		love.event.push("quit")
	end
end

-- Player draws
function Player:draw()
	love.graphics.draw(playerImg, self.x, self.y)
end

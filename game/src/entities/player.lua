-- Player File

-- Attempting to put every aspect of the player here and let
-- it load in the main file.

Player = {}
Player.__index = Player

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
	-- Set game type
	local isPlatformer = false
	local isTopDown = true
	local isRPG = false

	-- Define player keybinds
	if love.keyboard.isDown("left") then
		if self.x > 0 then
			self.x = self.x - (self.speed * dt)
		end
	elseif love.keyboard.isDown("right") then
		if self.x < (love.graphics.getWidth() - Image.player:getWidth()) then
			self.x = self.x + (self.speed * dt)
		end
	elseif love.keyboard.isDown("up") and isTopDown == true then
		if self.y > 0 then
			self.y = self.y - (self.speed * dt)
		end
	elseif love.keyboard.isDown("down") and isTopDown == true then
		if self.y < (love.graphics.getHeight() - Image.player:getHeight()) then
			self.y = self.y + (self.speed * dt)
		end
	elseif love.keyboard.isDown("escape") then
		love.event.push("quit")
	end
end

-- Player draws
function Player:draw()
	love.graphics.draw(Image.player, self.x, self.y)
end

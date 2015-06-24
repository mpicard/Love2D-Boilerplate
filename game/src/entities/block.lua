--[[
-- Block Class
-- This is the class that represents the walls, floors and "rocks".
--]]
local class  = require(LIBPATH .. "middleclass")
local util   = require(LIBPATH .. "util")
local Entity = require("src.entities.entity")

local Block = class('Block', Entity)

function Block:initialize(world, x,y,w,h, indestructible)
  Entity.initialize(self, world, x,y,w,h)
  self.indestructible = indestructible
	self.w = Image.wall:getWidth()
	self.h = Image.wall:getHeight()
end

function Block:draw()
  --util.drawFilledRectangle(self.x, self.y, self.w, self.h, 220, 150, 150)
	love.graphics.draw(Image.wall, self.x, self.y)
end

function Block:update(dt)
end

return Block

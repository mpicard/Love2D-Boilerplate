-- Map class

-- Call required libs
local class       = require(LIBPATH .. 'middleclass')
local bump        = require(LIBPATH .. 'bump')

-- Call entities
local Player      = require 'src.entities.player'
local Block       = require 'src.entities.block'
local Platform    = require 'src.entities.platform'

-- Custom variable
local random = math.random

local sortByUpdateOrder = function(a,b)
  return a:getUpdateOrder() < b:getUpdateOrder()
end

local sortByCreatedAt = function(a,b)
  return a.created_at < b.created_at
end

-- Create Map
local Map = class('Map')

function Map:initialize(width, height)
  self.width  = width
  self.height = height

  self:reset()
end

function Map:reset()

  local width, height = self.width, self.height
  self.world  = bump.newWorld()
  self.player = Player:new(self.world, 60, 60)

  -- Tiled Floor
  local tilesOnFloor = 32
  for i=0,tilesOnFloor - 1 do
    Block:new(self.world, i*width/tilesOnFloor, height-32, width/tilesOnFloor, 32, true)
  end

	-- Tiled Ceiling
	local tilesOnCeiling = 32
	for i=0,tilesOnCeiling - 1 do
		Block:new(self.world, i*width/tilesOnCeiling, 0, width/tilesOnCeiling, 32, true)
	end

	local wallTilesLeft = 32
	for i=0,wallTilesLeft - 1 do
		Block:new(self.world, 0, i*height/wallTilesLeft, width/wallTilesLeft, 32, true)
	end

	local wallTilesRight = 32
	for i=0,wallTilesRight - 1 do
		Block:new(self.world, width-32, i*height/wallTilesRight, width/wallTilesLeft, 32, true)
	end
	
  --Platform:new(self.world, { {x=100,y=950}, {x=200,y=950}, {x=200,y=850} })

  --local platforms = 40
  --for i=1,platforms do
    --local prev = { x = math.random(100, width-100), y = math.random(100, height - 100) }
    --local waypoints = {prev}
    --for i=2, math.random(2,6) do
      --local point = {
        --x = math.random(math.max(100, prev.x - 200), math.min(width-100, prev.x + 200)),
        --y = math.random(math.max(100, prev.y - 200), math.min(height-100, prev.y + 200))
      --}
      --waypoints[i] = point
      --prev = point
    --end
    --Platform:new(self.world, waypoints)
  --end

end


function Map:update(dt, l,t,w,h)
  l,t,w,h = l or 0, t or 0, w or self.width, h or self.height
  local visibleThings, len = self.world:queryRect(l,t,w,h)

  table.sort(visibleThings, sortByUpdateOrder)

  for i=1, len do
    visibleThings[i]:update(dt)
  end
end

function Map:draw(drawDebug, l,t,w,h)
  if drawDebug then bump_debug.draw(self.world, l,t,w,h) end

  local visibleThings, len = self.world:queryRect(l,t,w,h)

  table.sort(visibleThings, sortByCreatedAt)

  for i=1, len do
    visibleThings[i]:draw(drawDebug)
  end
end


return Map

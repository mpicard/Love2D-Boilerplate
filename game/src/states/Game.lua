Game = {}

function Game:enter()

	-- Set Physics Meter
	love.physics.setMeter(32)

	-- Load map
	map = sti.new("src/maps/TestMap")

	-- Prepare physics world
	world = love.physics.newWorld(0, 0)

	-- Prepare collision objects
	collision = map:initWorldCollision(world)

	-- Add a Custom Layer
	map:addCustomLayer("Sprite Layer", 2)

	local spriteLayer = map.layers["Sprite Layer"]

	-- Add Custom Data
	spriteLayer.sprite = {
		image = Image.player,
		x = 64,
		y = 64,
		r = 0,
	}

	spriteLayer.sprite.body			= love.physics.newBody(world, spriteLayer.sprite.x/2, spriteLayer.sprite.y/2, "dynamic")
	spriteLayer.sprite.shape		= love.physics.newRectangleShape(Image.player:getWidth(), Image.player:getHeight())
	spriteLayer.sprite.fixture	= love.physics.newFixture(spriteLayer.sprite.body, spriteLayer.sprite.shape)

	spriteLayer.sprite.body:setLinearDamping(10)


	-- Override Update callback
	function spriteLayer:update(dt)
	end

	-- Override Draw callback
	function spriteLayer:draw()
		local image = self.sprite.image
		local x = math.floor(self.sprite.x)
		local y = math.floor(self.sprite.y)
		local r = self.sprite.r
		love.graphics.draw(image, x, y, r, 1, 1, 32, 32)
	end
end

function Game:update(dt)
	-- Make sure to do this or nothign will work!
	world:update(dt)

	-- Update sprite's coordinates
	local sprite = map.layers["Sprite Layer"].sprite
	local down = love.keyboard.isDown

	local x, y = 0, 0
	if down("w") or down("up")		then y = y - 8000 end
	if down("s") or down("down")	then y = y + 8000 end
	if down("a") or down("left")	then x = x - 8000 end
	if down("d") or down("right")	then x = x + 8000 end
	sprite.body:applyForce(x, y)
	sprite.x, sprite.y = sprite.body:getWorldCenter()

	map:update(dt)
end

function Game:draw()
	local sprite = map.layers["Sprite Layer"].sprite
	local ww = love.graphics.getWidth()
	local wh = love.graphics.getHeight()
	local tx = math.floor(-sprite.x + ww / 2 - 16)
	local ty = math.floor(-sprite.y + wh / 2 - 16)

	-- Draw sprite in centre of screen
	love.graphics.push()
	love.graphics.translate(tx, ty)
	map:setDrawRange(tx, ty, ww, wh)
	map:draw()
	love.graphics.pop()
end

function love.resize(w, h)
	map:resize(w, h)
end

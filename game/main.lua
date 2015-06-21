-- Main Lua
-- Created by mavz42
--
-- Based on Headchant's boilerplate
-- https://github.com/headchant/love-boilerplate/
--

-- Set libs path
LIBPATH = "libs"
LIBPATH = LIBPATH .. "."

-- Call required libs manually
local debugging = require(LIBPATH .. "debugging")

-- Create a proxy via rawset
-- by vrld | https://github.com/vrld/Princess/blob/master/main.lua
local function Proxy(f)
	return setmetatable({}, {__index = function(self, k)
					local v = f(k)
					rawset(self, k, v)
					return v
	end } )
end

-- Standard proxies

-- [[ Usage:
-- love.graphics.draw(Image.background)
-- or
-- Sfx.explosion:play()
-- ]]

Image 	= Proxy(function(k) return love.graphics.newImage('gfx/' .. k .. '.png') end)
Sfx 		= Proxy(function(k) return love.audio.newSource('sfx' .. k .. '.ogg', 'static') end)
Music 	= Proxy(function(k) return love.audio.newSource('bgm' .. k .. '.ogg', 'stream') end)

-- Require all files in a folder and/or subfolders.
local function recursiveRequire(folder, tree)
	local tree = tree or {}
	for i,file in ipairs(love.filesystem.getDirectoryItems(folder)) do
		local filename = folder.."/"..file
		if love.filesystem.isDirectory(filename) then
			recursiveRequire(filename)
		elseif file ~= ".DS_Store" then
			require(filename:gsub(".lua",""))
		end
	end
	return tree
end

local function extractFileName(str)
	return string.match(str, "(.-)([^\\/]-%.?([^%.\\/]*))$")
end

-- Initialization
function love.load()
	-- Load important stuff
	math.randomseed(os.time())
	love.graphics.setDefaultFilter("nearest", "nearest")
	recursiveRequire("src")
	--Gamestate.registerEvents()
	--Gamestate.switch(Menu)
	-- Create the player
	pl = Player.create()
end

-- Game Logic
function love.update(dt)
	-- Update the player using it's own update method
	pl:update(dt)
end

-- Asset Rendering
function love.draw()
	-- Call debug functions from sometext.lua
	printStatus()
	printFPS()

	-- Draw player
	pl:draw()
end

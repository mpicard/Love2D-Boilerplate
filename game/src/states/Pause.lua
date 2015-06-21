-- Pause Gamestate

Pause = {}

function Pause:enter(from)
    self.from = from -- Record your previous state
end

function Pause:draw()
    local W, H = love.graphics.getWidth(), love.graphics.getHeight()
    -- Draw previous state
    self.from:draw()
		-- Display pause menu
    love.graphics.setColor(0,0,0, 100)
    love.graphics.rectangle('fill', 0,0, W,H)
    love.graphics.setColor(255,255,255)
    love.graphics.printf('PAUSE', 0, H/2, W, 'center')
end

-- Define Pause keybinds
function love.keypressed(key)
    if Gamestate.current() == Game and key == 'p' then
        return Gamestate.push(Pause)
		elseif Gamestate.current() == Pause and key == 'p' then
				return Gamestate.pop()
    end
end

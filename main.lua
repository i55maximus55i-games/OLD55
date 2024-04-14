local class = require("Luaoop").class

require 'load_assets'
require 'player'
require 'platform'
require 'b2d_contact_listener'

debugRender = true

-- This function is called exactly once at the beginning of the game.
function love.load(args)
    -- Физика
    love.physics.setMeter(60)
    b2d_world = love.physics.newWorld(0, 1000, true)
    b2d_world:setCallbacks(beginContact, endContact, preSolve, postSolve)

    for y = 0,5 do
        for x = 0, 3 do
            platform_create(50 + x * 600 + (y % 2) * 300, 200 + 150 * y, 150, 150)
        end
    end
    -- platform_create(1920 / 2, 200, 1920, 40)
end
	
-- Callback function used to update the state of the game every frame.
function love.update(dt)
    player_update(dt)
    b2d_world:update(dt)
end

-- Callback function used to draw on the screen every frame.
function love.draw()
    love.graphics.draw(background, 0, 0, 0, 1920 / background:getWidth(), 1080 / background:getHeight())
    platform_draw()
    player_draw()
end

-- Callback function triggered when the game is closed. 	Added since 0.7.0 	
function love.quit()
    -- Хуячим true, если не надо закрывать приложение
end

function love.joystickadded(joystick)
    player_create(joystick, 40, 0)
end
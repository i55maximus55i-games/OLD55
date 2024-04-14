love.graphics.setDefaultFilter("nearest", "nearest")

require 'random_objects.o'

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

    -- for y = 2,5 do
    --     for x = 0, 3 do
    --         platform_create(50 + x * 600 + (y % 2) * 300, 200 + 150 * y, 150, 150)
    --     end
    -- end
    -- platform_create(1920 / 2, 200, 1920, 40)
    local x = 120
    local y = 250
    platform_create(x + 150 * 0, y + 150 * 0, 150, 150)
    platform_create(x + 150 * 0, y + 150 * 1, 150, 150)

    platform_create(x + 150 * 1, y + 150 * 4, 300, 150)
    -- platform_create(x + 150 * 1, y + 150 * 4, 150, 150)

    platform_create(x + 150 * 5, y + 150 * 3, 450, 150)
    -- platform_create(x + 150 * 4, y + 150 * 3, 150, 150)
    -- platform_create(x + 150 * 5, y + 150 * 3, 150, 150)

    platform_create(x + 150 * 8.6, y + 150 * 4, 300, 150)
    -- platform_create(x + 150 * 8, y + 150 * 4, 150, 150)

    platform_create(x + 150 * 9, y + 150 * 0, 150, 150)
    platform_create(x + 150 * 9, y + 150 * 1, 150, 150)
end
	
-- Callback function used to update the state of the game every frame.
function love.update(dt)
    player_update(dt)
    URO(dt)
    b2d_world:update(dt)
end

-- Callback function used to draw on the screen every frame.
function love.draw()
    love.graphics.scale(1.2,1.2)
    love.graphics.draw(background, 0, 0, 0, 1920 / background:getWidth(), 1080 / background:getHeight())
    platform_draw()
    DRO()
    player_draw()

    local dead = true
    love.graphics.print("Больжедор", 50, -10, 0, 4 / 1.2, 4 / 1.2)
    for i,v in pairs(players) do
        if v.index == 1 then 
            dead = false
        end
    end
    if dead then 
        love.graphics.print("Мёртвый", 50, 35, 0, 4 / 1.2, 4 / 1.2)
    else
        love.graphics.print("Жывой", 50, 35, 0, 4 / 1.2, 4 / 1.2)
    end

    love.graphics.print("Веталь", 400, -10, 0, 4 / 1.2, 4 / 1.2)
    dead = true
    for i,v in pairs(players) do
        if v.index == 2 then 
            dead = false
        end
    end
    if dead then 
        love.graphics.print("Мёртвый", 400, 35, 0, 4 / 1.2, 4 / 1.2)
    else
        love.graphics.print("Жывой", 400, 35, 0, 4 / 1.2, 4 / 1.2)
    end


    love.graphics.print("Герасимыч", 800, -10, 0, 4 / 1.2, 4 / 1.2)
    dead = true
    for i,v in pairs(players) do
        if v.index == 3 then 
            dead = false
        end
    end
    if dead then 
        love.graphics.print("Мёртвый", 800, 35, 0, 4 / 1.2, 4 / 1.2)
    else
        love.graphics.print("Жывой", 800, 35, 0, 4 / 1.2, 4 / 1.2)
    end


    love.graphics.print("Ахмыл", 1200, -10, 0, 4 / 1.2, 4 / 1.2)
    for i,v in pairs(players) do
        if v.index == 4 then 
            dead = false
        end
    end
    if dead then 
        love.graphics.print("Мёртвый", 1200, 35, 0, 4 / 1.2, 4 / 1.2)
    else
        love.graphics.print("Жывой", 1200, 35, 0, 4 / 1.2, 4 / 1.2)
    end
end

-- Callback function triggered when the game is closed. 	Added since 0.7.0 	
function love.quit()
    -- Хуячим true, если не надо закрывать приложение
end

function love.joystickadded(joystick)
    -- player_create(joystick, 40, 0)
end


function REMOVE_PLAYER( joystick )
    for i,v in pairs(players) do
        print(joystick, i)
        if joystick == i then
            players[joystick].body:destroy()
            players[joystick] = nil
        end
    end
end

function love.joystickremoved( joystick )
    REMOVE_PLAYER(joystick)
end
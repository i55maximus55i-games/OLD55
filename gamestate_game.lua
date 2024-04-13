local class = require("Luaoop").class

require 'gamestate'


b2d_world = love.physics.newWorld(0, -100, true)
hrushevki = {}


GameState_Game = class("GameState_Game", GameState)
function GameState_Game:__construct() end
function GameState_Game:start() 
    love.physics.setMeter(60)
    b2d_world = love.physics.newWorld(0, 100, true)

    hrushevki[0] = {}
    hrushevki[0].body = love.physics.newBody(b2d_world, 0, 20, "dynamic")
    local shape = love.physics.newRectangleShape(40, 40)
    local fixture = love.physics.newFixture(hrushevki[0].body, shape, 1)

    body = love.physics.newBody(b2d_world, 0, 200, "static")
    shape = love.physics.newRectangleShape(100, 10)
    fixture = love.physics.newFixture(body, shape)
end
function GameState_Game:update(dt)
    b2d_world:update(1 / 60)
end
function GameState_Game:draw() 
    love.graphics.rectangle("fill", hrushevki[0].body:getX(), hrushevki[0].body:getY() - 20, 40, 40)
    love.graphics.rectangle("fill", body:getX(), body:getY() - 5, 100, 10)
end
function GameState_Game:exit() end

function GameState_Game:joystick_added(joystick) end
function GameState_Game:joystick_removed(joystick) end
function GameState_Game:player_added(player) end
function GameState_Game:player_removed(player) end
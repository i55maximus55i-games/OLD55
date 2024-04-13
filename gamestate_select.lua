require 'gamestate'
require 'player_manager'

GameState_Select = class("GameState_Select", GameState)
function GameState_Select:__construct() end
function GameState_Select:start() end
function GameState_Select:update(dt) 
    
end
function GameState_Select:draw() end
function GameState_Select:exit() end

function GameState_Select:joystick_added(joystick) end
function GameState_Select:joystick_removed(joystick) end
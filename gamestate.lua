local class = require("Luaoop").class


GameState = class("GameState")
function GameState:__construct() end
function GameState:start() end
function GameState:update(dt) end
function GameState:draw() end
function GameState:exit() end

function GameState:joystick_added(joystick) end
function GameState:joystick_removed(joystick) end
function GameState:player_added(player) end
function GameState:player_removed(player) end
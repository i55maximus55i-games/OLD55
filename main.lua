local class = require("Luaoop").class

require 'gamestate'
require 'player_manager'
require 'gamestate_game'

current_state = GameState()

-- This function is called exactly once at the beginning of the game.
function love.load(args)
    current_state = GameState_Game
    current_state.start()
end
	
-- Callback function used to update the state of the game every frame.
function love.update(dt)
    print(dt)
    current_state.update(dt)
end

-- Callback function used to draw on the screen every frame.
function love.draw()
    current_state.draw()
end

-- Callback function triggered when the game is closed. 	Added since 0.7.0 	
function love.quit()
    -- Хуячим true, если не надо закрывать приложение
end
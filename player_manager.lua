active_players_count = 0


available_joysticks_count = 0
available_joysticks = {}


function love.joystickadded(joystick)
    available_joysticks[available_joysticks_count] = joystick
    available_joysticks_count = available_joysticks_count + 1
    current_state.joystick_added(joystick)
end

function love.joystickremoved(joystick)
    current_state.joystick_removed(joystick)
end
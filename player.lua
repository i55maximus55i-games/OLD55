require 'load_assets'
local lightning = require 'random_objects.lightninig'
local lp = require 'random_objects.lightning_particle'
LOAD_PLAYER_ASSETS()
players = {}

player_width = 40
player_height = 60

require 'player_states'
function player_create(joystick, x, y, number)
    --- @class Player
    local player = {}

    player.j = joystick
    player.type = "player"
    player.body = love.physics.newBody(b2d_world, x, y, "dynamic")
    player.body:setFixedRotation(true)
    player.shape = love.physics.newRectangleShape(player_width, player_height)
    player.fixture = love.physics.newFixture(player.body, player.shape)
    player.fixture:setFriction(0.3)
    player.fixture:setUserData(player)

    player.state = "idle"
    player.stateTimer = 0
    player.dir = 1

    player.run = false
    player.stun = 0
    player.maxSpeedWalk = 250
    player.maxSpeedRun  = 500
    player.targerSpeed  = 0
    player.acceleration = 2000

    player.damage = 1
    player.damageTextTimer = 0

    player.jumpCounter = 0
    player.jumpTimer = 0
    player.isJump = false
    player.wallstick_timer = 0
    player.wallstick = 0

    player.isStickingToWall = false

    local available_index = 1
    for i=1,4 do
        local bad_index = false
        for k,v in pairs(players) do                                                                          
            if (v.index == i) then
                bad_index = true
                goto next_dude
            end
        end
        ::next_dude::

        if not bad_index then
            available_index = i
            break
        end
    end

    ::found::
    player.index = available_index

    player.current_state = player_states[player.index]

    player.mayjump = true

    players[joystick] = player
end

function player_draw()
    for i,v in pairs(players) do
        local x = v.body:getX()
        local y = v.body:getY()
        local state = v.state
        local playerSpriteIndex = 0 -- TODO
        local spriteIndex = math.floor(v.stateTimer / v.current_state[state].duration * v.current_state[state].length)
        local drawable = v.current_state[state].frames[spriteIndex].textures[playerSpriteIndex]
        local offsets = v.current_state[state].frames[spriteIndex].tex_offset or {x=0,y=0}

        love.graphics.draw(drawable, x-v.dir*player_width+offsets.x*v.dir, y-player_height+10+offsets.y*v.dir, 0, 2*v.dir,2)
        if v.damageTextTimer > 0 then
            love.graphics.print('x'..v.damage, x-20, y - 100, 0, 3 / 1.2, 3 / 1.2)
        end
        if debugRender then
            -- Физичный бох
            love.graphics.setColor(0.5, 0.5, 0.5, 1)
            love.graphics.rectangle("line", v.body:getX() - player_width / 2, v.body:getY() - player_height / 2, player_width, player_height)
            -- Хитбох
            local hitbox = v.current_state[state].frames[spriteIndex].hitbox
            love.graphics.setColor(0, 1, 0, 1)
            love.graphics.rectangle("line", v.body:getX() + hitbox.x, v.body:getY() + hitbox.y, hitbox.w, hitbox.h)
            -- Хуртбох
            local hurtbox = v.current_state[state].frames[spriteIndex].hurtbox
            if hurtbox.active then
                love.graphics.setColor(1, 0, 0, 1)
                love.graphics.rectangle("line", v.body:getX() + hurtbox.x * v.dir, v.body:getY() + hurtbox.y, hurtbox.w * v.dir, hurtbox.h)
            end

            love.graphics.setColor(1,1,1,1)
        end
    end
end

function player_update(dt)
    for i,player in pairs(players) do
        local left_x, left_y, right_x, right_y = i:getAxes()
        local vx, vy = player.body:getLinearVelocity()

        -- сбросить прыжок если прилетело в ебало
        if (player.stun > 0) then
            player.isJump = false
        end

        player.stateTimer = player.stateTimer + dt
        player.damageTextTimer = player.damageTextTimer - dt
        if player.stateTimer > player.current_state[player.state].duration then
            if player.state == "punch" or player.state == "slide" or player.state == "upper" then 
                player.state = "idle"
                player.stateTimer = 0
            end
            if player.state == "jump" then 
                player.stateTimer = 0.15 
            end
            if player.state == "idle" or player.state == "walk" or player.state == "run" or player.state == "run_punch" or player.state == "ass" then
                player.stateTimer = 0
            end
            if player.state == "sexkick" then
                player.stateTimer = 0.19
            end
        end

        player.stun = player.stun - dt

        if player.stun < 0 then
            -- ходит/бегит
            if player.state == "punch" then left_x = 0 end
            if player.state == "run_punch" then
                left_x = player.dir
            end
            if player.state == "slide" then
                left_x = player.dir * 2
            end
            if player.state == "ass" or player.state == "upper" then
                left_x = 0
            end
            local targetSpeed = left_x * player.maxSpeedWalk
            if math.abs(left_x) > 0.1 then
                if player.state == "slide" then
                elseif player.state == "sexkick" then
                elseif player.state == "ass" then
                else 
                    if player.state ~= "punch" then 
                        if left_x > 0 then player.dir = 1 else player.dir = -1 end
                        if not player.isJump then
                            if player.run then 
                                if player.state == "run_punch" then
                                    left_x = player.dir
                                else 
                                    player.state = "run" 
                                end
                            else 
                                player.state = "walk"
                            end
                        else
                            player.state = "jump"
                        end
                    end
                end
            else
                if player.state ~= "punch" then 
                    if player.state == "upper" then
                        
                    else 
                        if player.isJump then
                            if player.state == "sexkick" then
                            elseif player.state == "ass" then
                            else
                                player.state = "jump" 
                            end
                        else 
                            player.state = "idle" 
                            player.stateTimer = 0
                        end
                    end
                end
            end
            if player.run then targetSpeed = left_x * player.maxSpeedRun end

            local mass = player.body:getMass()
            local acceleration = (targetSpeed - vx) / dt
            if acceleration < -player.acceleration then acceleration = -player.acceleration end
            if acceleration >  player.acceleration then acceleration =  player.acceleration end
            player.body:applyForce(acceleration * mass, 0)

            -- прилипат
            if player.wallstick ~= 0 then
                player.dir = player.wallstick
                if player.state ~= "wallSlide" then
                    player.state = "wallSlide"
                    player.stateTimer = 0
                    player.isStickingToWall = true
                end
                local vx, vy = player.body:getLinearVelocity()
                player.body:setLinearVelocity(vx, 0)
                -- if player.isJump then
                    -- player.body:applyLinearImpulse(player.wallstick * 200, -80)
                    -- player.wallstick = 0
                    -- player.isJump = true
                -- end
            else
                if player.state == "wallSlide" then
                    player.state = "idle"
                    player.stateTimer = 0
                end
            end
        else
            player.state = "stun"
            player.stateTimer = 0
        end

        -- Проверка хитохуртобоксов
        local p1_x = player.body:getX()
        local p1_y = player.body:getY()
        local state = player.state
        local spriteIndex = math.floor(player.stateTimer / player.current_state[state].duration * player.current_state[state].length)
        local hurtbox = player.current_state[state].frames[spriteIndex].hurtbox
        if hurtbox.active then
            p1_x = p1_x + hurtbox.x
            p1_y = p1_y + hurtbox.y
            for other_i,other_player in pairs(players) do
                if i ~= other_i then
                    local p2_x = other_player.body:getX()
                    local p2_y = other_player.body:getY()
                    local state = other_player.state
                    local spriteIndex = math.floor(other_player.stateTimer / player.current_state[state].duration * player.current_state[state].length)
                    local hitbox = player.current_state[state].frames[spriteIndex].hitbox
                    p2_x = p2_x + hitbox.x
                    p2_y = p2_y + hitbox.y
    
                    -- love.graphics.rectangle("line", v.body:getX() + hurtbox.x * v.dir, v.body:getY() + hurtbox.y, hurtbox.w * v.dir, hurtbox.h)
                    if player.dir > 0 then
                        if p1_x < p2_x + hitbox.w and p1_x + hurtbox.w> p2_x and p1_y < p2_y + hitbox.h and p1_y + hurtbox.h > p2_y then
                            player_hit(player, other_player)
                        end
                    else
                        if p1_x - hurtbox.x * 4 < p2_x + hitbox.w and p1_x - hurtbox.x * 4 + hurtbox.w > p2_x and p1_y < p2_y + hitbox.h and p1_y + hurtbox.h > p2_y then
                            player_hit(player, other_player)
                        end
                    end
                end
            end
        end

        if p1_y > 1080 then
            REMOVE_PLAYER(i)
        end
    end
end

-- player1 тот кто въебал
-- player2 тот кому въебали
---comment
---@param attacker Player
---@param defender Player
function player_hit(attacker, defender)
    local active_state = attacker.current_state[attacker.state]
    print(attacker.stateTimer, active_state.duration, active_state)
    local active_frame = active_state.frames[ math.floor(attacker.stateTimer / active_state.duration * active_state.length) ]

    -- defender.body:applyLinearImpulse(0, -1000)
    local v = {}
    if (not active_frame.damage_vector) then return end
    v.x = active_frame.damage_vector.x
    v.y = active_frame.damage_vector.y
    if (v) then
        defender.damage = defender.damage + 0.4
        defender.damageTextTimer = 0.6
        print(defender.damage)
        v.x = v.x * defender.damage
        v.y = v.y * defender.damage
        defender.body:setLinearVelocity(v.x * attacker.dir, v.y)
        defender.stun = 0.4 * defender.damage

        for i=0,3 do
            CRO(lp, {}, defender.body:getX()+math.random(-20,20), defender.body:getY()+math.random(-20,20))
          end

        local lvx, lvy = attacker.body:getLinearVelocity()
        attacker.body:setLinearVelocity(lvx/4,lvy/2)
        -- defender.state = 'stun'

    end

    print('ъуъ')
end

function player_control(joystick, butt, pressed)
    --- @type Player
    local player = players[joystick]
    local left_x, left_y, right_x, right_y = joystick:getAxes()

    if not player then return end
    

    print(butt)
    
    -- бегит
    if butt >= 5 and butt <= 8 then
        player.run = pressed
        player.stateTimer = 0
    end
    
    -- Прыг
    if butt == 3 then
        if pressed then
            if player.stun < 0 then
                if player.jumpCounter <= 2 then
                    player.jumpTimer = 0.3
                    player.jumpCounter = player.jumpCounter + 1
                    local p_xv, p_yv = player.body:getLinearVelocity()
                    local extra_x_push = 0
                    if player.isStickingToWall then
                        print(player.wallstick)
                        extra_x_push = player.wallstick * 400
                        player.wallstick = 0
                    end
                    player.body:setLinearVelocity(p_xv + extra_x_push, -700)
                    player.isJump = true
                    player.state = "jump"
                    player.stateTimer = 0
                end
            end
        else
            local vx, vy = player.body:getLinearVelocity()
            if (player.isJump and vy < 0) then
                player.body:setLinearVelocity(vx, -10)
            end
            player.jumpCounter = player.jumpCounter + 1
        end
    end
    -- Пиздинг
    if butt == 4 then
        if pressed then
            if not player.isJump then
                -- Slide
                if left_y > 0.2 then
                    player.state = "slide"
                    player.stateTimer = 0
                elseif left_y < -0.2 then
                    -- апперхуй
                    if player.jumpCounter <= 3 then
                        player.state = "upper"
                        local vx = player.body:getLinearVelocity()
                        player.body:setLinearVelocity(vx, -550)
                        player.stateTimer = 0
                        player.jumpCounter = player.jumpCounter + 1
                    end
                else 
                    -- Jab
                    if player.state == "idle" or player.state == "walk" then
                        player.state = "punch"
                        player.stateTimer = 0
                    end
                    -- Shoulder
                    if player.state == "run" then 
                        player.state = "run_punch"
                        player.stateTimer = 0
                        player.body:applyLinearImpulse(player.dir*300, -140)
                    end
                end
            else
                if left_y > 0.2 then
                    -- Атака вниз 
                    player.state = "ass"
                    player.stateTimer = 0
                elseif left_y < -0.2 then
                    -- Апперхуй
                    if player.jumpCounter <= 3 then
                        player.state = "upper"
                        local vx = player.body:getLinearVelocity()
                        player.body:setLinearVelocity(vx, -550)
                        player.stateTimer = 0
                        player.jumpCounter = player.jumpCounter + 1
                    end
                else
                    -- атака простая
                    player.state = "sexkick"
                    player.stateTimer = 0
                end
            end
        end
    end
end
function love.joystickpressed(joystick, butt)
    if (butt == 10) then
        local exists = false
        for i,v in pairs(players) do
            if i == joystick then
                exists = true
            end
        end

        if ( not exists ) then
            -- player_create(joystick, 100, 0)
            local may_spawn = true
            for _, object in pairs(RANDOM_OBJECTS) do
                if object and object.j ~= joystick then
                    may_spawn = false
                end
            end
            if may_spawn then
                CRO(lightning, {j = joystick},  1920 / 2 / 1.2 - 30, 0)
            end
        end
    end
    player_control(joystick, butt, true)
end

function love.joystickreleased(joystick, butt)
    player_control(joystick, butt, false)
end
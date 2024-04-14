require 'load_assets'

LOAD_PLAYER_ASSETS()
players = {}

player_width = 40
player_height = 60

require 'player_states'

function player_create(joystick, x, y)
    --- @class Player
    local player = {}

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

    player.jumpCounter = 0
    player.jumpTimer = 0
    player.isJump = false
    player.wallstick_timer = 0
    player.wallstick = 0

    player.isStickingToWall = false

    player.mayjump = true

    players[joystick] = player
end

function player_draw()
    for i,v in pairs(players) do
        local x = v.body:getX()
        local y = v.body:getY()
        local state = v.state
        local playerSpriteIndex = 0 -- TODO
        local spriteIndex = math.floor(v.stateTimer / player_states[state].duration * player_states[state].length)
        local drawable = player_states[state].frames[spriteIndex].textures[playerSpriteIndex]
        local offsets = player_states[state].frames[spriteIndex].tex_offset or {x=0,y=0}

        love.graphics.draw(drawable, x-v.dir*player_width+offsets.x*v.dir, y-player_height+10+offsets.y*v.dir, 0, 2*v.dir,2)
        if debugRender then
            -- Физичный бох
            love.graphics.setColor(0.5, 0.5, 0.5, 1)
            love.graphics.rectangle("line", v.body:getX() - player_width / 2, v.body:getY() - player_height / 2, player_width, player_height)
            -- Хитбох
            local hitbox = player_states[state].frames[spriteIndex].hitbox
            love.graphics.setColor(0, 1, 0, 1)
            love.graphics.rectangle("line", v.body:getX() + hitbox.x, v.body:getY() + hitbox.y, hitbox.w, hitbox.h)
            -- Хуртбох
            local hurtbox = player_states[state].frames[spriteIndex].hurtbox
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
        if player.stateTimer > player_states[player.state].duration then
            if player.state == "punch" then 
                player.state = "idle"
                player.stateTimer = 0
            end
            if player.state == "jump" then 
                player.stateTimer = 0.15 
            end
            if player.state == "idle" or player.state == "walk" or player.state == "run" or player.state == "run_punch" then
                player.stateTimer = 0
            end
        end

        player.stun = player.stun - dt

        if player.stun < 0 then
            -- ходит/бегит
            local targetSpeed = left_x * player.maxSpeedWalk
            if player.state == "punch" then left_x = 0 end
            if math.abs(left_x) > 0.1 then
                if player.state ~= "punch" then 
                    if left_x > 0 then player.dir = 1 else player.dir = -1 end
                    if not player.isJump then
                        if player.run then 
                            if player.state == "run_punch" then
                                
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
            else
                if player.state ~= "punch" then 
                    if player.isJump then player.state = "jump" else 
                        player.state = "idle" 
                        player.stateTimer = 0
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
        end

        -- Проверка хитохуртобоксов
        local p1_x = player.body:getX()
        local p1_y = player.body:getY()
        local state = player.state
        local spriteIndex = math.floor(player.stateTimer / player_states[state].duration * player_states[state].length)
        local hurtbox = player_states[state].frames[spriteIndex].hurtbox
        if hurtbox.active then
            p1_x = p1_x + hurtbox.x
            p1_y = p1_y + hurtbox.y
            for other_i,other_player in pairs(players) do
                if i ~= other_i then
                    local p2_x = other_player.body:getX()
                    local p2_y = other_player.body:getY()
                    local state = other_player.state
                    local spriteIndex = math.floor(other_player.stateTimer / player_states[state].duration * player_states[state].length)
                    local hitbox = player_states[state].frames[spriteIndex].hitbox
                    p2_x = p2_x + hitbox.x
                    p2_y = p2_y + hitbox.y
    
                    -- love.graphics.rectangle("line", v.body:getX() + hurtbox.x * v.dir, v.body:getY() + hurtbox.y, hurtbox.w * v.dir, hurtbox.h)
                    if player.dir > 0 then
                        if p1_x < p2_x + hitbox.w and p1_x + hurtbox.w> p2_x and p1_y < p2_y + hitbox.h and p1_y + hurtbox.h > p2_y then
                            player_hit(player, other_player)
                        end
                    else
                        if p1_x - hurtbox.x * 2 < p2_x + hitbox.w and p1_x - hurtbox.x * 2 + hurtbox.w > p2_x and p1_y < p2_y + hitbox.h and p1_y + hurtbox.h > p2_y then
                            player_hit(player, other_player)
                        end
                    end
                end
            end
        end
    end
end

-- player1 тот кто въебал
-- player2 тот кому въебали
function player_hit(player1, player2)

end

function player_control(joystick, butt, pressed)
    --- @type Player
    local player = players[joystick]
    
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
    if butt == 2 then
        if pressed then
            if not player.isJump then
                if player.state == "idle" or player.state == "walk" then
                    player.state = "punch"
                    player.stateTimer = 0
                end
                if player.state == "run" then 
                    player.state = "run_punch"
                    player.stateTimer = 0
                    player.body:applyLinearImpulse(0, -140)
                end
            end
        end
    end
end

function love.joystickpressed(joystick, butt)
    player_control(joystick, butt, true)
end

function love.joystickreleased(joystick, butt)
    player_control(joystick, butt, false)
end
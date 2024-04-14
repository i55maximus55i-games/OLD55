require 'load_assets'

players = {}

player_width = 40
player_height = 60


player_states = {}
player_states["idle"] = {}
player_states["idle"].duration = 1
player_states["idle"].length = 1
player_states["idle"].tiles = {}
player_states["idle"].tiles[0] = {} 
player_states["idle"].tiles[0].textures = {} 
player_states["idle"].tiles[0].textures[0] = blue_idle
player_states["idle"].tiles[0].hitbox = {x=-15,y=-30,w=30,h=60}
player_states["idle"].tiles[0].hurtbox = {active=false}

player_states["wallSlide"] = {}
player_states["wallSlide"].duration = 1
player_states["wallSlide"].length = 1
player_states["wallSlide"].tiles = {}
player_states["wallSlide"].tiles[0] = {} 
player_states["wallSlide"].tiles[0].textures = {} 
player_states["wallSlide"].tiles[0].textures[0] = blue_wallslide
player_states["wallSlide"].tiles[0].hitbox = {x=0,y=0,w=40,h=60}
player_states["wallSlide"].tiles[0].hurtbox = {active=false}

player_states["punch"] = {}
player_states["punch"].duration = 2
player_states["punch"].length = 4
player_states["punch"].tiles = {}
player_states["punch"].tiles[0] = {} 
player_states["punch"].tiles[0].textures = {} 
player_states["punch"].tiles[0].textures[0] = green_jab[1]
player_states["punch"].tiles[0].hitbox = {x=-15,y=-30,w=30,h=60}
player_states["punch"].tiles[0].hurtbox = {active=false}
player_states["punch"].tiles[1] = {} 
player_states["punch"].tiles[1].textures = {} 
player_states["punch"].tiles[1].textures[0] = green_jab[2]
player_states["punch"].tiles[1].hitbox = {x=-15,y=-30,w=30,h=60}
player_states["punch"].tiles[1].hurtbox = {active=true, x=20,y=0,w=30, h=30}
player_states["punch"].tiles[2] = {} 
player_states["punch"].tiles[2].textures = {} 
player_states["punch"].tiles[2].textures[0] = green_jab[3]
player_states["punch"].tiles[2].hitbox = {x=-15,y=-30,w=30,h=60}
player_states["punch"].tiles[2].hurtbox = {active=false}
player_states["punch"].tiles[3] = {} 
player_states["punch"].tiles[3].textures = {} 
player_states["punch"].tiles[3].textures[0] = green_jab[4]
player_states["punch"].tiles[3].hitbox = {x=-15,y=-30,w=30,h=60}
player_states["punch"].tiles[3].hurtbox = {active=true, x=20,y=0,w=30, h=30}



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
    player.acceleration = 1500

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
        local drawable = player_states[state].tiles[spriteIndex].textures[playerSpriteIndex]

        love.graphics.draw(drawable, x, y, 0)
        if debugRender then
            -- Физичный бох
            love.graphics.setColor(0.5, 0.5, 0.5, 1)
            love.graphics.rectangle("line", v.body:getX() - player_width / 2, v.body:getY() - player_height / 2, player_width, player_height)
            -- Хитбох
            local hitbox = player_states[state].tiles[spriteIndex].hitbox
            love.graphics.setColor(0, 1, 0, 1)
            love.graphics.rectangle("line", v.body:getX() + hitbox.x, v.body:getY() + hitbox.y, hitbox.w, hitbox.h)
            -- Хуртбох
            local hurtbox = player_states[state].tiles[spriteIndex].hurtbox
            if hurtbox.active then
                love.graphics.setColor(1, 0, 0, 1)
                love.graphics.rectangle("line", v.body:getX() + hurtbox.x, v.body:getY() + hurtbox.y, hurtbox.w, hurtbox.h)
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
            if player.state == "punch" then player.state = "idle" end
            player.stateTimer = 0
        end

        player.stun = player.stun - dt

        if player.stun < 0 then
            -- ходит/бегит
            local targetSpeed = left_x * player.maxSpeedWalk
            if math.abs(left_x) > 0.1 then
                if left_x > 0 then player.dir = 1 else player.dir = -1
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
        local hurtbox = player_states[state].tiles[spriteIndex].hurtbox
        if hurtbox.active then
            p1_x = p1_x + hurtbox.x
            p1_y = p1_y + hurtbox.y
            for other_i,other_player in pairs(players) do
                if i ~= other_i then
                    local p2_x = other_player.body:getX()
                    local p2_y = other_player.body:getY()
                    local state = other_player.state
                    local spriteIndex = math.floor(other_player.stateTimer / player_states[state].duration * player_states[state].length)
                    local hitbox = player_states[state].tiles[spriteIndex].hitbox
                    p2_x = p2_x + hitbox.x
                    p2_y = p2_y + hitbox.y
    
                    if p1_x < p2_x + hitbox.w and p1_x + hurtbox.w > p2_x and p1_y < p2_y + hitbox.h and p1_y + hurtbox.h > p2_y then
                        player_hit(player, other_player)
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
                    player.body:setLinearVelocity(p_xv + extra_x_push, -500)
                    player.isJump = true
                    print('jump')
                end
            end
        else
            local vx, vy = player.body:getLinearVelocity()
            if (player.isJump and vy < 0 ) then
                
                player.body:setLinearVelocity(vx, -10)
            end
            player.jumpCounter = player.jumpCounter + 1
        end
    end
    -- Пиздинг
    if butt == 2 then
        if pressed then
            if player.state == "idle" then
                player.state = "punch"
                player.stateTimer = 0
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
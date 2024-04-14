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
player_states["wallSlime"] = {}
player_states["wallSlime"].duration = 1
player_states["wallSlime"].length = 1
player_states["wallSlime"].tiles = {}
player_states["wallSlime"].tiles[0] = {} 
player_states["wallSlime"].tiles[0].textures = {} 
player_states["wallSlime"].tiles[0].textures[0] = blue_wallslime

function player_create(joystick, x, y)
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

    players[joystick] = player
end

function player_draw()
    for i,v in pairs(players) do
        local x = v.body:getX()
        local y = v.body:getY()
        local state = v.state
        local playerSpriteIndex = 0 -- TODO
        local spriteIndex = math.floor(v.stateTimer / player_states[state].duration * player_states[state].length)
        local drawable = player_states[state].tiles[playerSpriteIndex].textures[spriteIndex]
        love.graphics.draw(drawable, x, y, 0)
        love.graphics.rectangle("line", v.body:getX() - player_width / 2, v.body:getY() - player_height / 2, player_width, player_height)
    end
end

function player_update(dt)
    for i,player in pairs(players) do
        local left_x, left_y, right_x, right_y = i:getAxes()
        local vx, vy = player.body:getLinearVelocity()

        player.stateTimer = player.stateTimer + dt
        if player.stateTimer > player_states[player.state].duration then
            if player.state == "idle" or player.state == "wallSlime" then player.stateTimer = 0 end
        end

        player.stun = player.stun - dt

        if player.stun < 0 then
            -- ходит/бегит
            local targetSpeed = left_x * player.maxSpeedWalk
            if player.run then targetSpeed = left_x * player.maxSpeedRun end
            local mass = player.body:getMass()
            local acceleration = (targetSpeed - vx) / dt
            if acceleration < -player.acceleration then acceleration = -player.acceleration end
            if acceleration >  player.acceleration then acceleration =  player.acceleration end
            player.body:applyForce(acceleration * mass, 0)

            -- прилипат
            if player.wallstick ~= 0 then
                if player.state ~= "wallSlime" then
                    player.state = "wallSlime"
                    player.stateTimer = 0
                end
                local vx, vy = player.body:getLinearVelocity()
                player.body:setLinearVelocity(vx, 0)
                if player.isJump then
                    player.body:applyLinearImpulse(player.wallstick * 200, -80)
                    player.wallstick = 0
                    player.isJump = false
                end
            else
                if player.state == "wallSlime" then
                    player.state = "idle"
                    player.stateTimer = 0
                end
            -- прыгат
                local vx, vy = player.body:getLinearVelocity()
                player.jumpTimer = player.jumpTimer - dt
                if player.isJump then
                    if player.jumpTimer > 0 then
                        vy = -200
                    else
                        vy = 0
                        player.isJump = false
                    end
                end
                player.body:setLinearVelocity(vx, vy)
            end
        end
    end
end

function love.joystickpressed(joystick, butt)
    local player = players[joystick]
    if butt == 3 then
        if player.stun < 0 then
            if player.jumpCounter <= 2 then
                player.jumpTimer = 0.3
                player.jumpCounter = player.jumpCounter + 1
                player.isJump = true
            end
        end
    --     if player.jumpCounter <= 2 then
    --         player.jumpTimer = 0.3
    --         player.jumpCounter = player.jumpCounter + 1
    --         player.body:setLinearVelocity(player.wallstick * 400, -1200)
    --         player.wallstick_timer = 0.16
    --         player.wallstick = 0
    --     end
    end
end

function love.joystickreleased(joystick, butt)
    local player = players[joystick]
    if butt == 3 then
        -- local player = players[joystick]
        -- player.run = false
        player.jumpTimer = 0.0
        player.jumpCounter = player.jumpCounter + 1
    end
end
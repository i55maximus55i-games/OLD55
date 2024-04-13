players = {}

player_width = 40
player_height = 60

function player_create(joystick, x, y)
    local player = {}

    player.type = "player"
    player.body      = love.physics.newBody(b2d_world, x, y, "dynamic")
    player.body:setFixedRotation(true)
    player.shape     = love.physics.newRectangleShape(player_width, player_height)
    player.fixture   = love.physics.newFixture(player.body, player.shape)
    player.fixture:setFriction(0.3)
    player.fixture:setUserData(player)

    player.run = false
    player.stun = 0
    player.maxSpeedWalk = 150
    player.maxSpeedRun  = 500
    player.targerSpeed  = 0
    player.acceleration = 900

    player.jumpCounter = 0
    player.jumpTimer = 0
    player.wallstick_timer = 0
    player.wallstick = 0

    players[joystick] = player
end

function player_draw()
    for i,v in pairs(players) do
        love.graphics.rectangle("fill", v.body:getX() - player_width / 2, v.body:getY() - player_height / 2, player_width, player_height)
    end
end

function player_update(dt)
    for i,player in pairs(players) do
        local left_x, left_y, right_x, right_y = i:getAxes()
        local vx, vy = player.body:getLinearVelocity()

        player.stun = player.stun - dt

        if player.stun < 0 then
            local targetSpeed = left_x * player.maxSpeedWalk
            if player.run then targetSpeed = left_x * player.maxSpeedRun end
            local mass = player.body:getMass()
            local acceleration = (targetSpeed - vx) / dt
            if acceleration < -player.acceleration then acceleration = -player.acceleration end
            if acceleration >  player.acceleration then acceleration =  player.acceleration end
            player.body:applyForce(acceleration * mass, 0)
        end


        -- player.jumpTimer = player.jumpTimer - dt
        -- player.wallstick_timer = player.wallstick_timer - dt
        -- if player.wallstick_timer < 0 then
        --     vx = left_x * 500
        -- end
        -- if player.jumpTimer > 0 then
        --     vy = -500
        -- end
        -- if player.wallstick == -1 then
        --     vy = 0
        -- end
        -- player.body:setLinearVelocity(vx, vy)
        -- -- print(i:isDown(3))
    end
end

function love.joystickpressed(joystick, butt)
    if butt == 3 then
        local player = players[joystick]
        player.run = true
    --     if player.jumpCounter <= 2 then
    --         player.jumpTimer = 0.3
    --         player.jumpCounter = player.jumpCounter + 1
    --         player.body:setLinearVelocity(player.wallstick * 400, -1200)
    --         player.wallstick_timer = 0.16
    --         player.wallstick = 0
    --     end
    end
    -- print(joystick, butt)
end

function love.joystickreleased(joystick, butt)
    if butt == 3 then
        local player = players[joystick]
        player.run = false
    --     player.jumpTimer = 0.0
    --     player.jumpCounter = player.jumpCounter + 1
    end
end
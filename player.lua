players = {}

player_width = 40
player_height = 60

function player_create(joystick, x, y)
    local player = {}
    player.body      = love.physics.newBody(b2d_world, x, y, "dynamic")
    player.body:setFixedRotation(true)
    player.shape     = love.physics.newRectangleShape(player_width, player_height)
    player.fixture   = love.physics.newFixture(player.body, player.shape)
    player.fixture:setFriction(0.3)

    players[joystick] = player
end

function player_draw()
    for i,v in pairs(players) do
        love.graphics.rectangle("fill", v.body:getX() - player_width / 2, v.body:getY() - player_height / 2, player_width, player_height)
    end
end

function player_update(dt)
    for i,v in pairs(players) do
        local left_x, left_y, right_x, right_y = i:getAxes()
        local vx, vy = v.body:getLinearVelocity()
        v.body:setLinearVelocity(left_x * 500, vy)
        print(i:isDown(3))
    end
end

function love.joystickpressed(joystick, butt)
    if butt == 3 then
        local player = players[joystick]
        local vx, vy = player.body:getLinearVelocity()
        player.body:setLinearVelocity(vx, -600)
    end
    print(joystick, butt)
end
platforms = {}
platforms_n = 0

function platform_create(x, y, width, height)
    local platform = {}

    local i = math.floor(love.math.random(1, 10))
    platform.drawable = hrush[i]

    platform.width     = width
    platform.height    = height

    platform.type      = "platform"
    platform.body      = love.physics.newBody(b2d_world, x, y, "static")
    platform.shape     = love.physics.newRectangleShape(platform.width, platform.height)
    platform.fixture   = love.physics.newFixture(platform.body, platform.shape)
    platform.fixture:setFriction(0.4)
    platform.fixture:setUserData(platform)

    local left_border = {}
    left_border.type    = "platform_left"
    left_border.body    = love.physics.newBody(b2d_world, x - width / 2 - 2, y, "static")
    left_border.shape   = love.physics.newRectangleShape(4, height / 4 - 2)
    left_border.fixture = love.physics.newFixture(left_border.body, left_border.shape)
    left_border.fixture:setSensor(true)
    left_border.fixture:setUserData(left_border)
    platform.left_border = left_border

    local right_border = {}
    right_border.type    = "platform_right"
    right_border.body    = love.physics.newBody(b2d_world, x + width / 2 + 2, y, "static")
    right_border.shape   = love.physics.newRectangleShape(4, height / 4 - 2)
    right_border.fixture = love.physics.newFixture(right_border.body, right_border.shape)
    right_border.fixture:setSensor(true)
    right_border.fixture:setUserData(right_border)
    platform.right_border = right_border

    local up_border = {}
    up_border.type    = "platform_up"
    up_border.body    = love.physics.newBody(b2d_world, x, y - height / 2 - 2, "static")
    up_border.shape   = love.physics.newRectangleShape(width - 2, 4)
    up_border.fixture = love.physics.newFixture(up_border.body, up_border.shape)
    up_border.fixture:setSensor(true)
    up_border.fixture:setUserData(up_border)
    platform.up_border = up_border
    
    platforms[platforms_n] = platform
    platforms_n = platforms_n + 1
end

function platform_draw()
    for i,v in pairs(platforms) do
        local platformDrawable = v.drawable
        love.graphics.draw(platformDrawable, v.body:getX() - v.width / 2, v.body:getY() - v.height / 2, 0, v.width / platformDrawable:getWidth(), v.height / platformDrawable:getHeight())
    end
end
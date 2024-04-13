platforms = {}
platforms_n = 0

function platform_create(x, y, width, height)
    local platform = {}
    platform.width     = width
    platform.height    = height

    platform.body      = love.physics.newBody(b2d_world, x, y, "static")
    platform.shape     = love.physics.newRectangleShape(platform.width, platform.height)
    platform.fixture   = love.physics.newFixture(platform.body, platform.shape)
    platform.fixture:setFriction(0.1)

    local left_border = {}
    left_border.body    = love.physics.newBody(b2d_world, x - width / 2 - 2, y, "static")
    left_border.shape   = love.physics.newRectangleShape(4, height - 2)
    left_border.fixture = love.physics.newFixture(left_border.body, left_border.shape)
    left_border.fixture:setSensor(true)
    platform.left_border = left_border

    local right_border = {}
    right_border.body    = love.physics.newBody(b2d_world, x + width / 2 + 2, y, "static")
    right_border.shape   = love.physics.newRectangleShape(4, height - 2)
    right_border.fixture = love.physics.newFixture(right_border.body, right_border.shape)
    right_border.fixture:setSensor(true)
    platform.right_border = right_border
    
    platforms[platforms_n] = platform
    platforms_n = platforms_n + 1
end

function platform_draw()
    local platformDrawable = background
    for i,v in pairs(platforms) do
        love.graphics.draw(platformDrawable, v.body:getX() - v.width / 2, v.body:getY() - v.height / 2, 0, v.width / background:getWidth(), v.height / background:getHeight())
    end
end
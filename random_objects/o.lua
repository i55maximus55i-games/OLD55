RANDOM_OBJECTS = {}

function CRO(in_o, extra, x, y)

  local o = {}

  for i,v in pairs (in_o) do
    o[i] = v
  end

  for i,v in pairs (extra) do
    o[i] = v
  end

  if (not o.nophys) then
    o.type = "random"
    o.body = love.physics.newBody(b2d_world, x, y, "dynamic")
    o.body:setFixedRotation(true)
    o.shape = love.physics.newRectangleShape(40, 40)
    o.fixture = love.physics.newFixture(o.body, o.shape)
    o.fixture:setFriction(0.3)
    o.fixture:setUserData(o)
    o.fixture:setSensor(true)
  else
    o.shit_x = x
    o.shit_y = y
    o.shit_dx = 0
    o.shit_dy = 0
  end
  
  
  if (o.create) then
    o:create()
  end
  RANDOM_OBJECTS[#RANDOM_OBJECTS+1] = o
end

function URO(dt)
  for i,v in pairs(RANDOM_OBJECTS) do
    if (v) then
      if (v.nophys) then
        v.shit_x = v.shit_x + v.shit_dx*dt
        v.shit_y = v.shit_y + v.shit_dy*dt
      end
      v:update(dt)
      if v.deleteme then
        if (not v.nophys) then
          v.body:destroy()
        end
        RANDOM_OBJECTS[i] = nil
      end
    end
  end
end

function DRO()
  for i,v in pairs(RANDOM_OBJECTS) do
    if (v) then
      v:draw()
    end
  end
end
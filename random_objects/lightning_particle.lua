
local sprites = {
  love.graphics.newImage('random/lightning/1.png'),
  love.graphics.newImage('random/lightning/2.png'),
  love.graphics.newImage('random/lightning/3.png'),
  love.graphics.newImage('random/lightning/4.png')
}

return {
  dietime = 0.3,
  t = 0,
  nophys = true,
  create = function (self)

    self.scale = math.random(-5,5)*0.25
    self.sprite_index = math.random(1,4)

    -- self.body:setGravityScale(0)
    -- self.fixture:setSensor(true)
    -- self.body:setLinearVelocity(math.random(-100,100), math.random(-100,100))
  end,
  update = function (self, dt)
    self.t = self.t + dt
    if (self.t > self.dietime) then
      self.deleteme = true
    end
  end,
  draw = function (self)
    love.graphics.draw(sprites[self.sprite_index], self.shit_x, self.shit_y, 0, self.scale)
  end,
  collide = function (self, other)
    if other:getUserData().type == 'platform' then
      self:getUserData().done = true
    end
  end
}
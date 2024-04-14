
local sprites = {
  love.graphics.newImage('random/lightning/1.png'),
  love.graphics.newImage('random/lightning/2.png'),
  love.graphics.newImage('random/lightning/3.png'),
  love.graphics.newImage('random/lightning/4.png')
}

return {
  dietime = 1,
  t = 0,
  create = function (self)

    self.sprite_index = math.random(1,4)

    self.body:setGravityScale(0)
    self.fixture:setSensor(true)
    self.body:setLinearVelocity(math.random(-100,100), math.random(-100,100))
  end,
  update = function (self, dt)
    self.t = self.t + dt
    if (self.t > self.dietime) then
      self.deleteme = true
    end
  end,
  draw = function (self)
    local x = self.body:getX()
    local y = self.body:getY()
    love.graphics.draw(sprites[self.sprite_index], x, y)
  end,
  collide = function (self, other)
    if other:getUserData().type == 'platform' then
      self:getUserData().done = true
    end
  end
}
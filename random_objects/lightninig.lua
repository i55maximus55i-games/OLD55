
local l_sprite = love.graphics.newImage('random/lightning/1.png')

local lp = require 'random_objects.lightning_particle'
local splash = require 'random_objects.splash'

return {
  create = function(self) 
    self.body:setLinearVelocity(0,500)
  end,
  update = function (self, dt)
    
    local x = self.body:getX()
    local y = self.body:getY()
    if (self.done) then
      player_create(self.j, self.body:getX(), self.body:getY())
      self.deleteme = true
      CRO(splash, {left = false}, x, y-40)
      CRO(splash, {left = true}, x, y-40)
    end
    for i=0,3 do
      CRO(lp, {}, x+math.random(-20,20), y+math.random(-20,20))
    end
  end,
  draw = function (self)
    local x = self.body:getX()
    local y = self.body:getY()
    love.graphics.draw(l_sprite, x, y)
  end,
  collide = function (self, other)
    if other:getUserData().type == 'platform' then
      self:getUserData().done = true
    end
  end
}
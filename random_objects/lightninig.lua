
local l_sprite = love.graphics.newImage('random/lightning/1.png')

local lp = require 'random_objects.lightning_particle'

return {
  create = function(self) 
    
  end,
  update = function (self, dt)
    
    local x = self.body:getX()
    local y = self.body:getY()
    if (self.done) then
      player_create(self.j, self.body:getX(), self.body:getY())
      self.deleteme = true
    end
    CRO(lp, {}, x, y)
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
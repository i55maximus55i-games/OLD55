local spr = love.graphics.newImage('random/halfsphere/1.png')

return {
  create = function(self) 
    if (self.left) then
      self.shit_dx = -1000
    else
      self.shit_dx = 1000
    end
  end,
  draw = function (self)
    local flip = self.left and 1 or -1
    local x_offset = 0
    if not flip then
      x_offset = 40
    end
    love.graphics.draw(spr, self.shit_x+x_offset, self.shit_y,0,2*flip,2)
  end,
  nophys = true,
  t = 0, 
  update = function (self, dt)
    self.t = self.t + dt
    if (self.t > 0.3) then
      self.deleteme = true
    end
  end
}
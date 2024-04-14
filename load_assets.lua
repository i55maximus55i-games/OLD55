background = love.graphics.newImage('assets/tiles/backdrop.png')
hrush = {}
for i = 1,10 do
    hrush[i] = love.graphics.newImage('assets/tiles/'..i..'.png')
end
blue_idle = love.graphics.newImage('assets/blue_idle_00.png')
blue_wallslime = love.graphics.newImage('assets/blue_kick_02.png')

green_jab = {}
for i = 1,4 do
    green_jab[i] = love.graphics.newImage('new_anim/1/jab/'..i..'.png')
end

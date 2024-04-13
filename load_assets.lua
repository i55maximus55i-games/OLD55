function load_assets()
    background = love.graphics.newImage('assets/tiles/backdrop.png')
    hrush = {}
    for i = 1,10 do
        hrush[i] = love.graphics.newImage('assets/tiles/'..i..'.png')
    end
end
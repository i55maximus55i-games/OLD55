background = love.graphics.newImage('assets/tiles/backdrop.png')
hrush = {}
for i = 1,10 do
    hrush[i] = love.graphics.newImage('assets/tiles/'..i..'.png')
end
blue_idle = love.graphics.newImage('assets/blue_idle_00.png')
blue_wallslide = love.graphics.newImage('assets/blue_kick_02.png')

green_jab = {}
for i = 1,4 do
    green_jab[i] = love.graphics.newImage('new_anim/1/jab/'..i..'.png')
end

local animation_list= {
    {
        name = "ass",
        count = 1,
    },
    {
        name = "charge",
        count = 4,
    },
    {
        name = "fly",
        count = 1,
    },
    {
        name = "fuckingdead",
        count = 1,
    },
    {
        name = "hadouken",
        count = 4,
    },
    {
        name = "jab",
        count = 4,
    },
    {
        name = "ass",
        count = 1,
    },
    {
        name = "jump",
        count = 2
    },
    {
        name = "megapunch",
        count = 1,
    },
    {
        name = "run",
        count = 4,
    },
    {
        name = "sexkick",
        count = 3,
    },
    {
        name = "shoulder",
        count = 1,
    },
    {
        name = "slide",
        count = 3,
    },
    {
        name = "stand",
        count = 1,
    },
    {
        name = "uppercut",
        count = 1,
    },
    {
        name = "wallhang",
        count = 1,
    },
    {
        name = "walk",
        count = 2
    }
}

PLAYER_COUNT = 1

ASSETS = {}
function LOAD_PLAYER_ASSETS() 
    for player_index=1,PLAYER_COUNT do
        ASSETS[player_index] = {}
        for _,adef in pairs(animation_list) do
            ASSETS[player_index][adef.name] = {}
            for animation_number=1,adef.count do
                ASSETS[player_index][adef.name][animation_number] = love.graphics.newImage('new_anim/' .. player_index .. '/' .. adef.name .. '/' .. animation_number .. '.png')
            end
        end
    end
end

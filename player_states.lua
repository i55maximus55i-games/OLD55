player_states = {}
player_states["idle"] = {}
player_states["idle"].duration = 1
player_states["idle"].length = 1
player_states["idle"].frames = {}
player_states["idle"].frames[0] = {} 
player_states["idle"].frames[0].textures = {} 
player_states["idle"].frames[0].textures[0] = ASSETS[2].stand[1]
player_states["idle"].frames[0].hitbox = {x=-15,y=-30,w=30,h=60}
player_states["idle"].frames[0].hurtbox = {active=false}

player_states["stun"] = {}
player_states["stun"].duration = 1
player_states["stun"].length = 1
player_states["stun"].frames = {}
player_states["stun"].frames[0] = {} 
player_states["stun"].frames[0].textures = {} 
player_states["stun"].frames[0].textures[0] = ASSETS[2].fly[1]
player_states["stun"].frames[0].hitbox = {x=-1500000,y=-30,w=30,h=60}
player_states["stun"].frames[0].hurtbox = {active=false}

player_states["walk"] = {}
player_states["walk"].duration = 1
player_states["walk"].length = 2
player_states["walk"].frames = {}
player_states["walk"].frames[0] = {}
player_states["walk"].frames[0].textures = {} 
player_states["walk"].frames[0].textures[0] = ASSETS[2].walk[1]
player_states["walk"].frames[0].hitbox = {x=-15,y=-30,w=30,h=60}
player_states["walk"].frames[0].hurtbox = {active=false}
player_states["walk"].frames[1] = {} 
player_states["walk"].frames[1].textures = {} 
player_states["walk"].frames[1].textures[0] = ASSETS[2].walk[2]
player_states["walk"].frames[1].hitbox = {x=-15,y=-30,w=30,h=60}
player_states["walk"].frames[1].hurtbox = {active=false}

player_states["run"] = {}
player_states["run"].duration = 0.4
player_states["run"].length = 4
player_states["run"].frames = {}
player_states["run"].frames[0] = {} 
player_states["run"].frames[0].textures = {} 
player_states["run"].frames[0].textures[0] = ASSETS[2].run[1]
player_states["run"].frames[0].hitbox = {x=-15,y=-30,w=30,h=60}
player_states["run"].frames[0].hurtbox = {active=false}
player_states["run"].frames[1] = {} 
player_states["run"].frames[1].textures = {} 
player_states["run"].frames[1].textures[0] = ASSETS[2].run[2]
player_states["run"].frames[1].hitbox = {x=-15,y=-30,w=30,h=60}
player_states["run"].frames[1].hurtbox = {active=false}
player_states["run"].frames[2] = {} 
player_states["run"].frames[2].textures = {} 
player_states["run"].frames[2].textures[0] = ASSETS[2].run[3]
player_states["run"].frames[2].hitbox = {x=-15,y=-30,w=30,h=60}
player_states["run"].frames[2].hurtbox = {active=false}
player_states["run"].frames[3] = {} 
player_states["run"].frames[3].textures = {} 
player_states["run"].frames[3].textures[0] = ASSETS[2].run[4]
player_states["run"].frames[3].hitbox = {x=-15,y=-30,w=30,h=60}
player_states["run"].frames[3].hurtbox = {active=false}

player_states["wallSlide"] = {}
player_states["wallSlide"].duration = 1
player_states["wallSlide"].length = 1
player_states["wallSlide"].frames = {}
player_states["wallSlide"].frames[0] = {} 
player_states["wallSlide"].frames[0].textures = {} 
player_states["wallSlide"].frames[0].textures[0] = ASSETS[2].wallhang[1]
player_states["wallSlide"].frames[0].hitbox = {x=-15,y=-30,w=30,h=60}
player_states["wallSlide"].frames[0].hurtbox = {active=false}
player_states["wallSlide"].frames[0].tex_offset = {x=-10,y=0}

player_states["punch"] = {}
player_states["punch"].duration = 0.35
player_states["punch"].length = 4
player_states["punch"].frames = {}
player_states["punch"].frames[0] = {} 
player_states["punch"].frames[0].textures = {} 
player_states["punch"].frames[0].textures[0] = ASSETS[2].jab[1]
player_states["punch"].frames[0].hitbox = {x=-15,y=-30,w=30,h=60}
player_states["punch"].frames[0].hurtbox = {active=false}
player_states["punch"].frames[1] = {} 
player_states["punch"].frames[1].textures = {} 
player_states["punch"].frames[1].textures[0] = ASSETS[2].jab[2]
player_states["punch"].frames[1].hitbox = {x=-15,y=-30,w=30,h=60}
player_states["punch"].frames[1].hurtbox = {active=true, x=20,y=0,w=30, h=30}
player_states["punch"].frames[1].damage_vector = {x=100, y=-100}
player_states["punch"].frames[2] = {} 
player_states["punch"].frames[2].textures = {} 
player_states["punch"].frames[2].textures[0] = ASSETS[2].jab[3]
player_states["punch"].frames[2].hitbox = {x=-15,y=-30,w=30,h=60}
player_states["punch"].frames[2].hurtbox = {active=false}
player_states["punch"].frames[3] = {} 
player_states["punch"].frames[3].textures = {} 
player_states["punch"].frames[3].textures[0] = ASSETS[2].jab[4]
player_states["punch"].frames[3].hitbox = {x=-15,y=-30,w=30,h=60}
player_states["punch"].frames[3].hurtbox = {active=true, x=20,y=0,w=30, h=30}
player_states["punch"].frames[3].damage_vector = {x=100, y=-100}

player_states["run_punch"] = {}
player_states["run_punch"].duration = 1
player_states["run_punch"].length = 1
player_states["run_punch"].frames = {}
player_states["run_punch"].frames[0] = {} 
player_states["run_punch"].frames[0].textures = {} 
player_states["run_punch"].frames[0].textures[0] = ASSETS[2].shoulder[1]
player_states["run_punch"].frames[0].hitbox = {x=-15,y=-30,w=30,h=60}
player_states["run_punch"].frames[0].hurtbox = {active=true, x = 20, y = -20, w = 40, h = 40}
player_states["run_punch"].frames[0].damage_vector = {x=100, y=-100}

player_states["jump"] = {}
player_states["jump"].duration = 0.2
player_states["jump"].length = 2
player_states["jump"].frames = {}
player_states["jump"].frames[0] = {} 
player_states["jump"].frames[0].textures = {} 
player_states["jump"].frames[0].textures[0] = ASSETS[2].jump[1]
player_states["jump"].frames[0].hitbox = {x=-15,y=-30,w=30,h=60}
player_states["jump"].frames[0].hurtbox = {active=false}
player_states["jump"].frames[1] = {} 
player_states["jump"].frames[1].textures = {} 
player_states["jump"].frames[1].textures[0] = ASSETS[2].jump[2]
player_states["jump"].frames[1].hitbox = {x=-15,y=-30,w=30,h=60}
player_states["jump"].frames[1].hurtbox = {active=false}

player_states["slide"] = {}
player_states["slide"].duration = 0.35
player_states["slide"].length = 3
player_states["slide"].frames = {}
player_states["slide"].frames[0] = {} 
player_states["slide"].frames[0].textures = {} 
player_states["slide"].frames[0].textures[0] = ASSETS[2].slide[1]
player_states["slide"].frames[0].hitbox = {x=-15,y=-30,w=30,h=60}
player_states["slide"].frames[0].hurtbox = {active=false}
player_states["slide"].frames[1] = {} 
player_states["slide"].frames[1].textures = {} 
player_states["slide"].frames[1].textures[0] = ASSETS[2].slide[2]
player_states["slide"].frames[1].hitbox = {x=-15,y=-30,w=30,h=60}
player_states["slide"].frames[1].hurtbox = {active=false}
player_states["slide"].frames[2] = {} 
player_states["slide"].frames[2].textures = {} 
player_states["slide"].frames[2].textures[0] = ASSETS[2].slide[3]
player_states["slide"].frames[2].hitbox = {x=-15,y=-30,w=30,h=60}
player_states["slide"].frames[2].hurtbox = {active=true, x=20,y=0,w=30, h=30}
player_states["slide"].frames[2].damage_vector = {x=100, y=-100}

player_states["sexkick"] = {}
player_states["sexkick"].duration = 0.2
player_states["sexkick"].length = 3
player_states["sexkick"].frames = {}
player_states["sexkick"].frames[0] = {} 
player_states["sexkick"].frames[0].textures = {} 
player_states["sexkick"].frames[0].textures[0] = ASSETS[2].sexkick[1]
player_states["sexkick"].frames[0].hitbox = {x=-15,y=-30,w=30,h=60}
player_states["sexkick"].frames[0].hurtbox = {active=false}
player_states["sexkick"].frames[1] = {} 
player_states["sexkick"].frames[1].textures = {} 
player_states["sexkick"].frames[1].textures[0] = ASSETS[2].sexkick[2]
player_states["sexkick"].frames[1].hitbox = {x=-15,y=-30,w=30,h=60}
player_states["sexkick"].frames[1].hurtbox = {active=false}
player_states["sexkick"].frames[2] = {} 
player_states["sexkick"].frames[2].textures = {} 
player_states["sexkick"].frames[2].textures[0] = ASSETS[2].sexkick[3]
player_states["sexkick"].frames[2].hitbox = {x=-15,y=-30,w=30,h=60}
player_states["sexkick"].frames[2].hurtbox = {active=true, x = 20, y = -20, w = 40, h = 40}
player_states["sexkick"].frames[2].damage_vector = {x=100, y=-100}

player_states["ass"] = {}
player_states["ass"].duration = 1
player_states["ass"].length = 1
player_states["ass"].frames = {}
player_states["ass"].frames[0] = {} 
player_states["ass"].frames[0].textures = {} 
player_states["ass"].frames[0].textures[0] = ASSETS[2].ass[1]
player_states["ass"].frames[0].hitbox = {x=-15,y=-30,w=30,h=60}
player_states["ass"].frames[0].hurtbox = {active=true, x = -20, y = 20, w = 40, h = 40}
player_states["ass"].frames[0].damage_vector = {x=100, y=-100}

player_states["upper"] = {}
player_states["upper"].duration = 0.24
player_states["upper"].length = 3
player_states["upper"].frames = {}
player_states["upper"].frames[0] = {} 
player_states["upper"].frames[0].textures = {} 
player_states["upper"].frames[0].textures[0] = ASSETS[2].sexkick[1]
player_states["upper"].frames[0].hitbox = {x=-15,y=-30,w=30,h=60}
player_states["upper"].frames[0].hurtbox = {active=false}
player_states["upper"].frames[1] = {} 
player_states["upper"].frames[1].textures = {} 
player_states["upper"].frames[1].textures[0] = ASSETS[2].sexkick[2]
player_states["upper"].frames[1].hitbox = {x=-15,y=-30,w=30,h=60}
player_states["upper"].frames[1].hurtbox = {active=true, x = 20, y = -20, w = 40, h = 40}
player_states["upper"].frames[2] = {} 
player_states["upper"].frames[2].textures = {} 
player_states["upper"].frames[2].textures[0] = ASSETS[2].sexkick[3]
player_states["upper"].frames[2].hitbox = {x=-15,y=-30,w=30,h=60}
player_states["upper"].frames[2].hurtbox = {active=true, x = 20, y = -20, w = 40, h = 40}
player_states["upper"].frames[2].damage_vector = {x=100, y=-100}
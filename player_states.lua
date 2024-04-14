player_states = {}
for i=1,4 do
  
local current_state = {}
player_states[i] = current_state
current_state["idle"] = {}
current_state["idle"].duration = 1
current_state["idle"].length = 1
current_state["idle"].frames = {}
current_state["idle"].frames[0] = {} 
current_state["idle"].frames[0].textures = {} 
current_state["idle"].frames[0].textures[0] = ASSETS[i].stand[1]
current_state["idle"].frames[0].hitbox = {x=-15,y=-30,w=30,h=60}
current_state["idle"].frames[0].hurtbox = {active=false}

current_state["stun"] = {}
current_state["stun"].duration = 1
current_state["stun"].length = 1
current_state["stun"].frames = {}
current_state["stun"].frames[0] = {} 
current_state["stun"].frames[0].textures = {} 
current_state["stun"].frames[0].textures[0] = ASSETS[i].fly[1]
current_state["stun"].frames[0].hitbox = {x=-1500000,y=-30,w=30,h=60}
current_state["stun"].frames[0].hurtbox = {active=false}

current_state["walk"] = {}
current_state["walk"].duration = 1
current_state["walk"].length = 2
current_state["walk"].frames = {}
current_state["walk"].frames[0] = {}
current_state["walk"].frames[0].textures = {} 
current_state["walk"].frames[0].textures[0] = ASSETS[i].walk[1]
current_state["walk"].frames[0].hitbox = {x=-15,y=-30,w=30,h=60}
current_state["walk"].frames[0].hurtbox = {active=false}
current_state["walk"].frames[1] = {} 
current_state["walk"].frames[1].textures = {} 
current_state["walk"].frames[1].textures[0] = ASSETS[i].walk[2]
current_state["walk"].frames[1].hitbox = {x=-15,y=-30,w=30,h=60}
current_state["walk"].frames[1].hurtbox = {active=false}

current_state["run"] = {}
current_state["run"].duration = 0.4
current_state["run"].length = 4
current_state["run"].frames = {}
current_state["run"].frames[0] = {} 
current_state["run"].frames[0].textures = {} 
current_state["run"].frames[0].textures[0] = ASSETS[i].run[1]
current_state["run"].frames[0].hitbox = {x=-15,y=-30,w=30,h=60}
current_state["run"].frames[0].hurtbox = {active=false}
current_state["run"].frames[1] = {} 
current_state["run"].frames[1].textures = {} 
current_state["run"].frames[1].textures[0] = ASSETS[i].run[2]
current_state["run"].frames[1].hitbox = {x=-15,y=-30,w=30,h=60}
current_state["run"].frames[1].hurtbox = {active=false}
current_state["run"].frames[2] = {} 
current_state["run"].frames[2].textures = {} 
current_state["run"].frames[2].textures[0] = ASSETS[i].run[3]
current_state["run"].frames[2].hitbox = {x=-15,y=-30,w=30,h=60}
current_state["run"].frames[2].hurtbox = {active=false}
current_state["run"].frames[3] = {} 
current_state["run"].frames[3].textures = {} 
current_state["run"].frames[3].textures[0] = ASSETS[i].run[4]
current_state["run"].frames[3].hitbox = {x=-15,y=-30,w=30,h=60}
current_state["run"].frames[3].hurtbox = {active=false}

current_state["wallSlide"] = {}
current_state["wallSlide"].duration = 1
current_state["wallSlide"].length = 1
current_state["wallSlide"].frames = {}
current_state["wallSlide"].frames[0] = {} 
current_state["wallSlide"].frames[0].textures = {} 
current_state["wallSlide"].frames[0].textures[0] = ASSETS[i].wallhang[1]
current_state["wallSlide"].frames[0].hitbox = {x=-15,y=-30,w=30,h=60}
current_state["wallSlide"].frames[0].hurtbox = {active=false}
current_state["wallSlide"].frames[0].tex_offset = {x=-10,y=0}

current_state["punch"] = {}
current_state["punch"].duration = 0.35
current_state["punch"].length = 4
current_state["punch"].frames = {}
current_state["punch"].frames[0] = {} 
current_state["punch"].frames[0].textures = {} 
current_state["punch"].frames[0].textures[0] = ASSETS[i].jab[1]
current_state["punch"].frames[0].hitbox = {x=-15,y=-30,w=30,h=60}
current_state["punch"].frames[0].hurtbox = {active=false}
current_state["punch"].frames[1] = {} 
current_state["punch"].frames[1].textures = {} 
current_state["punch"].frames[1].textures[0] = ASSETS[i].jab[2]
current_state["punch"].frames[1].hitbox = {x=-15,y=-30,w=30,h=60}
current_state["punch"].frames[1].hurtbox = {active=true, x=20,y=0,w=30, h=30}
current_state["punch"].frames[1].damage_vector = {x=100, y=-100}
current_state["punch"].frames[2] = {} 
current_state["punch"].frames[2].textures = {} 
current_state["punch"].frames[2].textures[0] = ASSETS[i].jab[3]
current_state["punch"].frames[2].hitbox = {x=-15,y=-30,w=30,h=60}
current_state["punch"].frames[2].hurtbox = {active=false}
current_state["punch"].frames[3] = {} 
current_state["punch"].frames[3].textures = {} 
current_state["punch"].frames[3].textures[0] = ASSETS[i].jab[4]
current_state["punch"].frames[3].hitbox = {x=-15,y=-30,w=30,h=60}
current_state["punch"].frames[3].hurtbox = {active=true, x=20,y=0,w=30, h=30}
current_state["punch"].frames[3].damage_vector = {x=100, y=-100}

current_state["run_punch"] = {}
current_state["run_punch"].duration = 1
current_state["run_punch"].length = 1
current_state["run_punch"].frames = {}
current_state["run_punch"].frames[0] = {} 
current_state["run_punch"].frames[0].textures = {} 
current_state["run_punch"].frames[0].textures[0] = ASSETS[i].shoulder[1]
current_state["run_punch"].frames[0].hitbox = {x=-15,y=-30,w=30,h=60}
current_state["run_punch"].frames[0].hurtbox = {active=true, x = 20, y = -20, w = 40, h = 40}
current_state["run_punch"].frames[0].damage_vector = {x=140, y=-200}

current_state["jump"] = {}
current_state["jump"].duration = 0.2
current_state["jump"].length = 2
current_state["jump"].frames = {}
current_state["jump"].frames[0] = {} 
current_state["jump"].frames[0].textures = {} 
current_state["jump"].frames[0].textures[0] = ASSETS[i].jump[1]
current_state["jump"].frames[0].hitbox = {x=-15,y=-30,w=30,h=60}
current_state["jump"].frames[0].hurtbox = {active=false}
current_state["jump"].frames[1] = {} 
current_state["jump"].frames[1].textures = {} 
current_state["jump"].frames[1].textures[0] = ASSETS[i].jump[2]
current_state["jump"].frames[1].hitbox = {x=-15,y=-30,w=30,h=60}
current_state["jump"].frames[1].hurtbox = {active=false}

current_state["slide"] = {}
current_state["slide"].duration = 0.35
current_state["slide"].length = 3
current_state["slide"].frames = {}
current_state["slide"].frames[0] = {} 
current_state["slide"].frames[0].textures = {} 
current_state["slide"].frames[0].textures[0] = ASSETS[i].slide[1]
current_state["slide"].frames[0].hitbox = {x=-15,y=-30,w=30,h=60}
current_state["slide"].frames[0].hurtbox = {active=false}
current_state["slide"].frames[1] = {} 
current_state["slide"].frames[1].textures = {} 
current_state["slide"].frames[1].textures[0] = ASSETS[i].slide[2]
current_state["slide"].frames[1].hitbox = {x=-15,y=-30,w=30,h=60}
current_state["slide"].frames[1].hurtbox = {active=false}
current_state["slide"].frames[2] = {} 
current_state["slide"].frames[2].textures = {} 
current_state["slide"].frames[2].textures[0] = ASSETS[i].slide[3]
current_state["slide"].frames[2].hitbox = {x=-15,y=-30,w=30,h=60}
current_state["slide"].frames[2].hurtbox = {active=true, x=0,y=0,w=30, h=30}
current_state["slide"].frames[2].damage_vector = {x=100, y=-300}

current_state["sexkick"] = {}
current_state["sexkick"].duration = 0.2
current_state["sexkick"].length = 3
current_state["sexkick"].frames = {}
current_state["sexkick"].frames[0] = {} 
current_state["sexkick"].frames[0].textures = {} 
current_state["sexkick"].frames[0].textures[0] = ASSETS[i].sexkick[1]
current_state["sexkick"].frames[0].hitbox = {x=-15,y=-30,w=30,h=60}
current_state["sexkick"].frames[0].hurtbox = {active=false}
current_state["sexkick"].frames[1] = {} 
current_state["sexkick"].frames[1].textures = {} 
current_state["sexkick"].frames[1].textures[0] = ASSETS[i].sexkick[2]
current_state["sexkick"].frames[1].hitbox = {x=-15,y=-30,w=30,h=60}
current_state["sexkick"].frames[1].hurtbox = {active=false}
current_state["sexkick"].frames[2] = {} 
current_state["sexkick"].frames[2].textures = {} 
current_state["sexkick"].frames[2].textures[0] = ASSETS[i].sexkick[3]
current_state["sexkick"].frames[2].hitbox = {x=-15,y=-30,w=30,h=60}
current_state["sexkick"].frames[2].hurtbox = {active=true, x = 0, y = 0, w = 40, h = 20}
current_state["sexkick"].frames[2].damage_vector = {x=100, y=-100}

current_state["ass"] = {}
current_state["ass"].duration = 1
current_state["ass"].length = 1
current_state["ass"].frames = {}
current_state["ass"].frames[0] = {} 
current_state["ass"].frames[0].textures = {} 
current_state["ass"].frames[0].textures[0] = ASSETS[i].ass[1]
current_state["ass"].frames[0].hitbox = {x=-15,y=-30,w=30,h=60}
current_state["ass"].frames[0].hurtbox = {active=true, x = 0, y = 0, w = 40, h = 40}
current_state["ass"].frames[0].damage_vector = {x=100, y=-100}

current_state["upper"] = {}
current_state["upper"].duration = 0.24
current_state["upper"].length = 3
current_state["upper"].frames = {}
current_state["upper"].frames[0] = {} 
current_state["upper"].frames[0].textures = {} 
current_state["upper"].frames[0].textures[0] = ASSETS[i].uppercut[1]
current_state["upper"].frames[0].hitbox = {x=-15,y=-30,w=30,h=60}
current_state["upper"].frames[0].hurtbox = {active=false}
current_state["upper"].frames[1] = {} 
current_state["upper"].frames[1].textures = {} 
current_state["upper"].frames[1].textures[0] = ASSETS[i].uppercut[2]
current_state["upper"].frames[1].hitbox = {x=-15,y=-30,w=30,h=60}
current_state["upper"].frames[1].hurtbox = {active=true, x = 20, y = -20, w = 40, h = 40}
current_state["upper"].frames[1].damage_vector = {x=100, y=-100}
current_state["upper"].frames[2] = {} 
current_state["upper"].frames[2].textures = {} 
current_state["upper"].frames[2].textures[0] = ASSETS[i].uppercut[3]
current_state["upper"].frames[2].hitbox = {x=-15,y=-30,w=30,h=60}
current_state["upper"].frames[2].hurtbox = {active=true, x = 20, y = -50, w = 40, h = 80}
current_state["upper"].frames[2].damage_vector = {x=100, y=-400}

end
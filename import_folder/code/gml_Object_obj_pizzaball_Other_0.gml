x = xstart
y = ystart
hsp = 0
vsp = 0
image_speed = 0.35
state = states.walk
sprite_index = (global.mod_graceball ? spr_pizzaball_idle1_grace : spr_pizzaball_idle1)
sit = true
stunned = 0
instance_create(x, y, obj_genericpoofeffect)

event_inherited()
image_speed = 0.35
sprite_index = (global.mod_femgerome == 1 ? choose(spr_femgerome_idle1, spr_femgerome_idle2, spr_femgerome_idle3) : choose(spr_gerome_idle1, spr_gerome_idle2, spr_gerome_idle3))
image_xscale = 1
grabbed = false
hsp = 0
vsp = 0
grav = 0.5
flash = true
unpickable = false
hp = 0
grounded = true
state = states.normal
playerid = obj_player1
mask_index = spr_player_mask
depth = -5
platformid = noone
hsp_carry = 0
vsp_carry = 0
thrown = false

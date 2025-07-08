depth = 50
event_inherited()
image_speed = 0.35
xoffset = 40
yoffset = 0
hsp = 0
vsp = 0
grav = 0.23
movespeed = 3
panic = false
playerid = obj_player1
state = states.normal
toppinpalette = spr_shroompalette
spr_intro = sprite_index
spr_run = sprite_index
spr_idle = sprite_index
spr_panic = sprite_index
spr_taunt = sprite_index
spr_intro_strongcold = sprite_index
spr_run_strongcold = sprite_index
spr_idle_strongcold = sprite_index
xprev = x
yprev = y
switch object_index
{
    case obj_pizzakinshroom:
        tv_do_expression(spr_tv_toppinshroom, 1)
        break
    case obj_pizzakinsausage:
        tv_do_expression(spr_tv_toppinsausage, 1)
        break
    case obj_pizzakinpineapple:
        tv_do_expression(spr_tv_toppinpineapple, 1)
        break
    case obj_pizzakincheese:
        tv_do_expression(spr_tv_toppincheese, 1)
        break
    case obj_pizzakintomato:
        tv_do_expression(spr_tv_toppintomato, 1)
        break
    default:
        tv_do_expression(spr_tv_exprcollect, 1)
        break
}


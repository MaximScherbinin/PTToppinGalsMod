if (room == rm_editor)
    return;
if (state == (134 << 0) && grounded && vsp > 0 && (obj_player1.state == (111 << 0) || (obj_player1.state == (198 << 0) && obj_player1.sprite_index == spr_playerN_noisecrusherland)) && bbox_in_camera(view_camera[0], 32))
    scr_pizzaball_go_to_thrown(0, -10)
arrowindex += 0.35
switch state
{
    case (126 << 0):
        scr_enemy_idle()
        break
    case (130 << 0):
        scr_enemy_turn()
        break
    case (134 << 0):
        scr_enemy_walk()
        break
    case (136 << 0):
        scr_enemy_land()
        break
    case (137 << 0):
        scr_pizzaball_hit()
        break
    case (148 << 0):
        scr_pizzaball_golf()
        break
    case (156 << 0):
        scr_pizzaball_thrown()
        break
    case (138 << 0):
        scr_enemy_stun()
        if (stunned > 0)
            stunned -= 1
        break
    case (129 << 0):
        scr_pizzagoblin_throw()
        break
    case (4 << 0):
        scr_pizzaball_grabbed()
        break
    case (154 << 0):
        scr_enemy_pummel()
        break
    case (155 << 0):
        scr_enemy_staggered()
        break
    case (125 << 0):
        scr_enemy_rage()
        break
    case (17 << 0):
        scr_enemy_ghostpossess()
        break
}

if (state != (148 << 0))
{
    shootup = 0
    arrow = 0
}
if (state == (156 << 0))
{
    if (blur_effect > 0)
        blur_effect--
    else
    {
        blur_effect = 2
        with (create_blur_afterimage(x, y, sprite_index, (image_index - 1), xscale))
            playerid = other.id
    }
}
if ((state == (134 << 0) || state == (126 << 0)) && sit)
{
    hsp = 0
    sprite_index = (global.mod_graceball ? spr_pizzaball_idle1_grace : spr_pizzaball_idle1)
}
if (state != (134 << 0))
    sit = 0
if (state == (138 << 0) && stunned > 100 && birdcreated == 0)
{
    birdcreated = 1
    with (instance_create(x, y, obj_enemybird))
        ID = other.id
}
if (state == (156 << 0) && (!instance_exists(pointerID)))
{
    pointerID = instance_create(x, y, obj_objecticontracker)
    pointerID.sprite_index = (global.mod_graceball ? spr_icon_pizzaball_grace : spr_icon_pizzaball)
    pointerID.objectID = id
}
if (state != (138 << 0))
    birdcreated = 0
if (flash == 1 && alarm[2] <= 0)
    alarm[2] = 0.15 * room_speed
if (bigcheeseID != noone)
{
    if ((!instance_exists(bigcheeseID)) || bigcheeseID.state != (74 << 0) || bigcheeseID.shot)
    {
        if (instance_exists(bigcheeseID) && bigcheeseID.object_index == obj_golfburger && sprite_index == stunfallspr)
            sprite_index = walkspr
        bigcheeseID = -4
    }
    else
        invincible = 1
}
else
    invincible = 0
if (hitbuffer > 0)
{
    invincible = 1
    hitbuffer--
}
if (state != (4 << 0))
    depth = 0
if (state != (138 << 0))
    thrown = 0
if (boundbox == 0)
{
    with (instance_create(x, y, obj_baddiecollisionbox))
    {
        sprite_index = other.sprite_index
        mask_index = other.sprite_index
        baddieID = other.id
        other.boundbox = 1
    }
}
if (state == (156 << 0))
{
    with (instance_place((x + xscale), y, obj_destructibles))
        instance_destroy()
    with (instance_place((x + hsp + xscale), y, obj_destructibles))
        instance_destroy()
    with (instance_place(x, (y + vsp + 1), obj_destructibles))
        instance_destroy()
    with (instance_place(x, (y + vsp - 1), obj_destructibles))
        instance_destroy()
    with (instance_place(x, (y + 1), obj_destructibles))
        instance_destroy()
    with (instance_place(x, (y - 1), obj_destructibles))
        instance_destroy()
}

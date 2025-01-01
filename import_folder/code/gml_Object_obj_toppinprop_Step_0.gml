mask_index = spr_player_mask
if (obj_player1.state == (84 << 0) && state != (84 << 0))
{
    storedstate = state
    storedsprite = sprite_index
    state = (84 << 0)
    if (idlespr == spr_toppincheese && random(100) <= 2)
    {
        instance_create(x, y, obj_tinytaunt)
        sprite_index = spr_toppincheese_special
        image_index = 0
    }
    else if (idlespr == spr_toppinpineapple && random(100) <= 2)
    {
        instance_create(x, y, obj_tinytaunt)
        sprite_index = spr_toppinpineapple_special
        image_index = 0
    }
    else if (idlespr == spr_toppinshroom && random(100) <= 2)
    {
        instance_create(x, y, obj_tinytaunt)
        sprite_index = spr_toppinshroom_special
        image_index = 0
        image_speed = 0.35
    }
    else
    {
        instance_create(x, y, obj_tinytaunt)
        sprite_index = tauntspr
        image_index = irandom(sprite_get_number(tauntspr) - 1)
    }
}
switch state
{
    case (0 << 0):
        sprite_index = movespr
        hsp = image_xscale * 2
        if scr_solid((x + sign(hsp)), y)
        {
            image_xscale *= -1
            hsp *= -1
        }
        else if (!((scr_solid((x + image_xscale * 32), (y + 31)) || place_meeting((x + image_xscale * 32), (y + 31), obj_platform))))
        {
            image_xscale *= -1
            hsp *= -1
        }
        x += hsp
        break
    case (126 << 0):
        sprite_index = idlespr
        hsp = 0
        break
    case (84 << 0):
        hsp = 0
        vsp = 0
        if (obj_player1.state != (84 << 0))
        {
            state = storedstate
            sprite_index = storedsprite
        }
        break
}

vsp = 0

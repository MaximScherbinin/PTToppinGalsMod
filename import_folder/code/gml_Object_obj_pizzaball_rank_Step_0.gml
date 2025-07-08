if global.mod_graceball
{
    switch sprite_index
    {
        case spr_pizzaball_rank1:
            sprite_index = spr_pizzaball_rank1_grace
            break
        case spr_pizzaball_rank2:
            sprite_index = spr_pizzaball_rank2_grace
            break
        case spr_pizzaball_rank3:
            sprite_index = spr_pizzaball_rank3_grace
            break
        case spr_pizzaball_rank4:
            sprite_index = spr_pizzaball_rank4_grace
            break
    }

}
if (state == states.transitioncutscene)
{
    var ty = obj_screensizer.actual_height / 2
    y -= movespeed
    if (abs(y - ty) < 200)
        movespeed = Approach(movespeed, 1, 0.05)
    if (abs(y - ty) < 16)
    {
        y = ty
        state = states.normal
    }
}
else if (state == states.fall)
{
    y += movespeed
    movespeed = Approach(movespeed, 8, 2)
    if (y > (obj_screensizer.actual_height + sprite_height))
        instance_destroy()
}
else if (collect > 0)
{
    if (alarm[0] == -1)
        alarm[0] = 5
}
else
{
    state = states.fall
    movespeed = -2
}

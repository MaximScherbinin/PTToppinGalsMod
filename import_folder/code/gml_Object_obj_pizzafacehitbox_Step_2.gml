if (!instance_exists(baddieID))
{
    instance_destroy()
    return;
}
x = baddieID.x
y = baddieID.y
if (baddieID.state == (134 << 0))
    sprite_index = global.mod_spr_pizzaface_attackend
else
    sprite_index = baddieID.mask_index
if (!obj_player1.ispeppino)
    sprite_index = global.mod_spr_pizzaface_attackend
mask_index = sprite_index

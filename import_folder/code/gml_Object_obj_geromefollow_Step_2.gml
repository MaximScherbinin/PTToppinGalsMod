yoffset = 0
if (state != (84 << 0))
{
    if (sprite_index != spr_collected && sprite_index != spr_taunt)
    {
        event_inherited()
        if (!do_end)
            visible = obj_player1.visible
        sprite_index = (x != xprevious ? spr_keymove : spr_keyidle)
        if ((xprevious - x) != 0)
            image_xscale = (-(sign(xprevious - x)))
        else if (playerid.hsp == 0)
            image_xscale = playerid.xscale
        if (obj_player1.state == (84 << 0))
        {
            sprite_index = spr_taunt
            image_index = irandom(sprite_get_number(sprite_index) - 1)
            state = (84 << 0)
            tauntID = instance_create(x, y, obj_baddietaunteffect)
        }
    }
}
else
{
    if (sprite_index != spr_collected)
    {
        var s = obj_player1.sprite_index
        if (s == obj_player1.spr_supertaunt1 || s == obj_player1.spr_supertaunt2 || s == obj_player1.spr_supertaunt3 || s == obj_player1.spr_supertaunt4 || s == 2668)
        {
            sprite_index = spr_collected
            image_index = 0
        }
    }
    if (obj_player1.state != (84 << 0) || (sprite_index == spr_collected && floor(image_index) == (image_number - 1)))
    {
        sprite_index = spr_keyidle
        instance_destroy(tauntID)
        state = (0 << 0)
    }
}
if (room == rank_room || room == timesuproom)
    visible = 0

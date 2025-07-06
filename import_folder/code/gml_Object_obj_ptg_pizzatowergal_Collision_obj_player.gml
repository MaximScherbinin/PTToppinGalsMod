if (other.key_up2)
{
    global.mod_pizzatowergal++
    fmod_event_one_shot("event:/sfx/ui/select")
    
    if (global.mod_pizzatowergal > 1)
        global.mod_pizzatowergal = 0
    
    if (global.mod_pizzatowergal == 0)
    {
        desc = "New Version (by Benny)"
        sprite_index = spr_PTG_femgeromeanon
    }
    
    if (global.mod_pizzatowergal == 1)
    {
        desc = "Old Version (by Monstoppinanon)"
        sprite_index = spr_PTG_monstoppinanon
    }
}

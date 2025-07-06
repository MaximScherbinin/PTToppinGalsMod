if (other.key_up2)
{
    global.mod_graceball++
    fmod_event_one_shot("event:/sfx/ui/select")
    
    if (global.mod_graceball > 1)
        global.mod_graceball = 0
    
    if (global.mod_graceball == 0)
    {
        desc = "Disabled"
        sprite_index = spr_pizzaball_idle1
    }
    
    if (global.mod_graceball == 1)
    {
        desc = "Enabled"
        sprite_index = spr_pizzaball_idle1_grace
    }
}

if (other.key_up2)
{
    global.mod_grannyhuman++
    fmod_event_one_shot("event:/sfx/ui/select")
    
    if (global.mod_grannyhuman > 1)
        global.mod_grannyhuman = 0
    
    if (global.mod_grannyhuman == 0)
    {
        desc = "Disabled"
        sprite_index = spr_tutorialgranny_sleep
    }
    
    if (global.mod_grannyhuman == 1)
    {
        desc = "Enabled"
        sprite_index = spr_tutorialgranny_sleep_human
    }
}

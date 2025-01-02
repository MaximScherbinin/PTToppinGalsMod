if (state != -1)
    return;
if other.key_up2
{
    global.mod_femgerome++
    fmod_event_one_shot("event:/sfx/ui/select")
    if (global.mod_femgerome > 1)
        global.mod_femgerome = 0
    if (global.mod_femgerome == 0)
    {
        desc = "Disabled"
        sprite_index = spr_gerome_collected
    }
    if (global.mod_femgerome == 1)
    {
        desc = "Enabled"
        sprite_index = spr_femgerome_collected
    }
}

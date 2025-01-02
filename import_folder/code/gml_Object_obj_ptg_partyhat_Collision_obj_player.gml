if other.key_up2
{
    global.mod_partyhat = (!global.mod_partyhat)
    fmod_event_one_shot("event:/sfx/ui/select")
    if global.mod_partyhat
        create_transformation_tip(txt)
}

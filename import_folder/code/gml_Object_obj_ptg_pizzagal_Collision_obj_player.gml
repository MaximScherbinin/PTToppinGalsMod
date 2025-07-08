if other.key_up2
{
    global.mod_pizzagal++
    fmod_event_one_shot("event:/sfx/ui/select")
    if (global.mod_pizzagal > 1)
        global.mod_pizzagal = 0
    if (global.mod_pizzagal == 0)
    {
        desc = "Disabled"
        sprite_index = spr_pizzaface
        global.mod_spr_pizzaface = spr_pizzaface
        global.mod_spr_timer_pizzaface1 = spr_timer_pizzaface1
        global.mod_spr_timer_pizzaface2 = spr_timer_pizzaface2
        global.mod_spr_timer_pizzaface3 = spr_timer_pizzaface3
        global.mod_spr_pizzaface_intro1 = spr_pizzaface_intro1
        global.mod_spr_pizzaface_intro2 = spr_pizzaface_intro2
        global.mod_spr_pizzaface_nosespit1 = spr_pizzaface_nosespit1
        global.mod_spr_pizzaface_nosespit2 = spr_pizzaface_nosespit2
        global.mod_spr_pizzaface_nosespit3 = spr_pizzaface_nosespit3
        global.mod_spr_pizzaface_attackstart = spr_pizzaface_attackstart
        global.mod_spr_pizzaface_attack = spr_pizzaface_attack
        global.mod_spr_pizzaface_attackland = spr_pizzaface_attackland
        global.mod_spr_pizzaface_attackend = spr_pizzaface_attackend
        global.mod_spr_pizzaface_attackjump = spr_pizzaface_attackjump
        global.mod_spr_pizzaface_stun = spr_pizzaface_stun
        global.mod_spr_pizzaface_hurt = spr_pizzaface_hurt
        global.mod_spr_pizzahead_intro1 = spr_pizzahead_intro1
        global.mod_spr_pizzahead_intro2 = spr_pizzahead_intro2
    }
    if (global.mod_pizzagal == 1)
    {
        desc = "Enabled"
        sprite_index = spr_pizzaface_gal
        global.mod_spr_pizzaface = spr_pizzaface_gal
        global.mod_spr_timer_pizzaface1 = spr_timer_pizzaface1_gal
        global.mod_spr_timer_pizzaface2 = spr_timer_pizzaface2_gal
        global.mod_spr_timer_pizzaface3 = spr_timer_pizzaface3_gal
        global.mod_spr_pizzaface_intro1 = spr_pizzaface_intro1_gal
        global.mod_spr_pizzaface_intro2 = spr_pizzaface_intro2_gal
        global.mod_spr_pizzaface_nosespit1 = spr_pizzaface_nosespit1_gal
        global.mod_spr_pizzaface_nosespit2 = spr_pizzaface_nosespit2_gal
        global.mod_spr_pizzaface_nosespit3 = spr_pizzaface_nosespit3_gal
        global.mod_spr_pizzaface_attackstart = spr_pizzaface_attackstart_gal
        global.mod_spr_pizzaface_attack = spr_pizzaface_attack_gal
        global.mod_spr_pizzaface_attackland = spr_pizzaface_attackland_gal
        global.mod_spr_pizzaface_attackend = spr_pizzaface_attackend_gal
        global.mod_spr_pizzaface_attackjump = spr_pizzaface_attackjump_gal
        global.mod_spr_pizzaface_stun = spr_pizzaface_stun_gal
        global.mod_spr_pizzaface_hurt = spr_pizzaface_hurt_gal
        global.mod_spr_pizzahead_intro1 = spr_pizzahead_intro1_gal
        global.mod_spr_pizzahead_intro2 = spr_pizzahead_intro2_gal
    }
}

if (other.key_up2)
{
    global.mod_pizzagal++
    fmod_event_one_shot("event:/sfx/ui/select")
    
    if (global.mod_pizzagal > 1)
        global.mod_pizzagal = 0
    
    if (global.mod_pizzagal == 0)
    {
        desc = "Disabled"
        sprite_index = spr_pizzaface
        global.mod_spr_pizzaface = 3190
        global.mod_spr_timer_pizzaface1 = 3159
        global.mod_spr_timer_pizzaface2 = 1308
        global.mod_spr_timer_pizzaface3 = 4130
        global.mod_spr_pizzaface_intro1 = 1652
        global.mod_spr_pizzaface_intro2 = 4639
        global.mod_spr_pizzaface_nosespit1 = 296
        global.mod_spr_pizzaface_nosespit2 = 1202
        global.mod_spr_pizzaface_nosespit3 = 1821
        global.mod_spr_pizzaface_attackstart = 3689
        global.mod_spr_pizzaface_attack = 4003
        global.mod_spr_pizzaface_attackland = 4501
        global.mod_spr_pizzaface_attackend = 4104
        global.mod_spr_pizzaface_attackjump = 2242
        global.mod_spr_pizzaface_stun = 800
        global.mod_spr_pizzaface_hurt = 1603
        global.mod_spr_pizzahead_intro1 = 365
        global.mod_spr_pizzahead_intro2 = 1145
    }
    
    if (global.mod_pizzagal == 1)
    {
        desc = "Enabled"
        sprite_index = spr_pizzaface_gal
        global.mod_spr_pizzaface = 4711
        global.mod_spr_timer_pizzaface1 = 4677
        global.mod_spr_timer_pizzaface2 = 4670
        global.mod_spr_timer_pizzaface3 = 4673
        global.mod_spr_pizzaface_intro1 = 4712
        global.mod_spr_pizzaface_intro2 = 4705
        global.mod_spr_pizzaface_nosespit1 = 4713
        global.mod_spr_pizzaface_nosespit2 = 4716
        global.mod_spr_pizzaface_nosespit3 = 4714
        global.mod_spr_pizzaface_attackstart = 4717
        global.mod_spr_pizzaface_attack = 4718
        global.mod_spr_pizzaface_attackland = 4708
        global.mod_spr_pizzaface_attackend = 4709
        global.mod_spr_pizzaface_attackjump = 4715
        global.mod_spr_pizzaface_stun = 4710
        global.mod_spr_pizzaface_hurt = 4707
        global.mod_spr_pizzahead_intro1 = 4719
        global.mod_spr_pizzahead_intro2 = 4706
    }
}

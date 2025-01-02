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
        global.mod_spr_pizzaface = 3169
        global.mod_spr_timer_pizzaface1 = 3138
        global.mod_spr_timer_pizzaface2 = 1300
        global.mod_spr_timer_pizzaface3 = 4098
        global.mod_spr_pizzaface_intro1 = 1643
        global.mod_spr_pizzaface_intro2 = 4598
        global.mod_spr_pizzaface_nosespit1 = 294
        global.mod_spr_pizzaface_nosespit2 = 1196
        global.mod_spr_pizzaface_nosespit3 = 1810
        global.mod_spr_pizzaface_attackstart = 3664
        global.mod_spr_pizzaface_attack = 3973
        global.mod_spr_pizzaface_attackland = 4464
        global.mod_spr_pizzaface_attackend = 4072
        global.mod_spr_pizzaface_attackjump = 2229
        global.mod_spr_pizzaface_stun = 794
        global.mod_spr_pizzaface_hurt = 1595
        global.mod_spr_pizzahead_intro1 = 362
        global.mod_spr_pizzahead_intro2 = 1139
    }
    if (global.mod_pizzagal == 1)
    {
        desc = "Enabled"
        sprite_index = spr_pizzaface_gal
        global.mod_spr_pizzaface = 4658
        global.mod_spr_timer_pizzaface1 = 4624
        global.mod_spr_timer_pizzaface2 = 4628
        global.mod_spr_timer_pizzaface3 = 4629
        global.mod_spr_pizzaface_intro1 = 4665
        global.mod_spr_pizzaface_intro2 = 4666
        global.mod_spr_pizzaface_nosespit1 = 4667
        global.mod_spr_pizzaface_nosespit2 = 4668
        global.mod_spr_pizzaface_nosespit3 = 4669
        global.mod_spr_pizzaface_attackstart = 4662
        global.mod_spr_pizzaface_attack = 4663
        global.mod_spr_pizzaface_attackland = 4661
        global.mod_spr_pizzaface_attackend = 4659
        global.mod_spr_pizzaface_attackjump = 4660
        global.mod_spr_pizzaface_stun = 4670
        global.mod_spr_pizzaface_hurt = 4664
        global.mod_spr_pizzahead_intro1 = 4657
        global.mod_spr_pizzahead_intro2 = 4699
    }
}

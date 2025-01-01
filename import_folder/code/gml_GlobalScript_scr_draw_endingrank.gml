function scr_draw_endingrank() //gml_Script_scr_draw_endingrank
{
    if (sprite_index == spr_rank_wow)
        lang_draw_sprite(spr_rank_wow_text, image_index, x, y)
    if (sprite_index == spr_rankN4 && global.mod_femgerome)
		draw_sprite_ext(spr_rankN4_femgerome, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha)
	else
		draw_self()
    var spr = -4
    switch sprite_index
    {
        case spr_rank_confused:
            spr = spr_rank_confused_text
            break
        case spr_rank_holyshit:
            spr = spr_rank_holyshit_text
            break
        case spr_rank_nojudgement:
            spr = spr_rank_nojudgement_text
            break
        case spr_rank_notbad:
            spr = spr_rank_notbad_text
            break
        case spr_rank_officer:
            spr = spr_rank_officer_text
            break
        case spr_rank_quick:
            spr = spr_rank_quick_text
            break
        case spr_rank_wow:
            spr = spr_rank_wow_text
            break
        case spr_rank_yousuck:
            spr = spr_rank_yousuck_text
            break
        case spr_rankN1:
            spr = spr_rankN1_text
            break
        case spr_rankN2:
            spr = spr_rankN2_text
            break
        case spr_rankN3:
            spr = spr_rankN3_text
            break
        case spr_rankN4:
            spr = spr_rankN4_text
            break
        case spr_rankN5:
            spr = spr_rankN5_text
            break
        case spr_rankN_holyshit:
            spr = spr_rankN_holyshit_text
            break
        case spr_rankN_quick:
            spr = spr_rankN_quick_text
            break
        case spr_rankN_wow:
            spr = spr_rankN_wow_text
            break
    }
	if (sprite_index == spr_rankN4 && global.mod_femgerome)
		spr = -4
    if (spr != -4 && (sprite_index != spr_rank_wow || lang_get_value("wow_front")))
        lang_draw_sprite(spr, image_index, x, y)
}

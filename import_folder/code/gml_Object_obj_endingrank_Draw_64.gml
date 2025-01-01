var bg_spr = spr_finalrankBG
if (!ispeppino)
    bg_spr = (global.mod_femgerome == 1 ? spr_finalrankBG_N_femgerome : spr_finalrankBG_N)
draw_sprite_tiled(bg_spr, bg_index, bg_x, bg_y)
scr_draw_endingrank()
if (sprite_index == spr_finaljudgement)
    lang_draw_sprite(spr_finaljudgement_text, 0, 0, 0)
else if (sprite_index == spr_finaljudgementN)
    lang_draw_sprite(spr_finaljudgementN_text, 0, 0, 0)
if brown
{
    shader_set(shd_rank)
    draw_set_alpha(brownfade)
    draw_sprite_tiled(bg_spr, bg_index, bg_x, bg_y)
    scr_draw_endingrank()
    reset_shader_fix()
    draw_set_alpha(1)
}
draw_set_font(lang_get_font("bigfont"))
draw_set_halign(fa_left)
draw_set_valign(fa_top)
for (var i = 0; i < array_length(text); i++)
{
    var b = text[i]
    if b[0]
        tdp_draw_text_color(48, (48 + 32 * i), b[1], 16777215, 16777215, 16777215, 16777215, 1)
}
tdp_text_commit(0, 0, obj_screensizer.actual_width, obj_screensizer.actual_height)
draw_set_alpha(fade)
draw_rectangle_color(0, 0, obj_screensizer.actual_width, obj_screensizer.actual_height, c_black, c_black, c_black, c_black, false)
draw_set_alpha(1)
if (state == (2 << 0))
{
    draw_set_font(global.combofont)
    draw_set_halign(fa_center)
    draw_set_valign(fa_middle)
    var _x = obj_screensizer.actual_width / 2 - 17
    lang_draw_sprite(spr_towerstatusmenu, 0, _x, (obj_screensizer.actual_height / 2))
    draw_text_color((_x + 8), (obj_screensizer.actual_height / 2 + 10), floor(percvisual), c_white, c_white, c_white, c_white, 1)
}

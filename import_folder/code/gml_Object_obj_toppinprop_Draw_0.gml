if (warpalette == 1)
{
    shader_set(global.Pal_Shader)
    pattern_set(global.Base_Pattern_Color, sprite_index, image_index, image_xscale, image_yscale, spr_peppattern8)
    pal_swap_set(toppinpalette, (idlespr == spr_toppinsausage ? 2 : (idlespr == spr_toppinshroom ? 2 : (idlespr == spr_toppincheese ? 2 : 1))), 0)
    draw_self()
    pattern_reset()
    shader_reset()
}
else if (idlespr == spr_toppinsausage || idlespr == spr_toppinshroom || idlespr == spr_toppincheese)
{
    shader_set(global.Pal_Shader)
    pattern_set(global.Base_Pattern_Color, sprite_index, image_index, image_xscale, image_yscale, global.palettetexture)
    pal_swap_set(toppinpalette, 1, 0)
    draw_self()
    pattern_reset()
    shader_reset()
}
else
    draw_self()
if global.mod_partyhat
    draw_sprite_ext(spr_toppinspartyhat, 0, x, (y - sprite_get_height(sprite_index) * 0.25 + (lengthdir_y(5, (current_time * 0.1)))), image_xscale, image_yscale, image_angle, image_blend, image_alpha)

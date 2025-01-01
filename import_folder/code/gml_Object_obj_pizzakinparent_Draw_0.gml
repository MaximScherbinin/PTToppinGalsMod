var r = string_letters(room_get_name(room))
if (string_copy(r, 1, 3) == "war")
{
    shader_set(global.Pal_Shader)
    pattern_set(global.Base_Pattern_Color, sprite_index, image_index, image_xscale, image_yscale, spr_peppattern8)
    pal_swap_set(toppinpalette, (object_index == obj_pizzakinsausage ? 2 : (object_index == obj_pizzakinshroom ? 2 : (object_index == obj_pizzakincheese ? 2 : 1))), 0)
    draw_self()
    pattern_reset()
    shader_reset()
}
else if (object_index == obj_pizzakinsausage || object_index == obj_pizzakinshroom || object_index == obj_pizzakincheese)
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

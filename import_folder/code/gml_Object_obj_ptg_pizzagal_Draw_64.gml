if (alpha > 0)
{
    var text = concat(title, "\n", desc)
    draw_set_font(lang_get_font("creditsfont"))
    draw_set_halign(fa_center)
    draw_set_valign(fa_bottom)
    draw_text_color((obj_screensizer.actual_width / 2), (obj_screensizer.actual_height - 16), text, c_white, c_white, c_white, c_white, alpha)
}

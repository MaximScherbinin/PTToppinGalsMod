if (state >= (0 << 0))
    draw_rectangle_color(0, 0, room_width, room_height, c_black, c_black, c_black, c_black, 0)
switch state
{
    case (0 << 0):
        draw_sprite_ext(rat.sprite_index, 0, rat.x, rat.y, rat.scale, rat.scale, 0, c_white, 1)
        for (var i = 0; i < array_length(toppin_array); i++)
        {
            var toppin = toppin_array[i]
            if (toppin.state != (3 << 0))
            {
                if (i <= 1 || i == 3)
                {
                    shader_set(global.Pal_Shader)
                    pattern_set(global.Base_Pattern_Color, sprite_index, image_index, image_xscale, image_yscale, -4)
                    pal_swap_set(toppin.spr_pal, 1, 0)
                }
                draw_sprite_ext(toppin.sprite_index, toppin.image_index, (toppin.state == 1 ? (toppin.x + (irandom_range(-1, 1))) : toppin.x), (toppin.state == 1 ? (toppin.y + (irandom_range(-1, 1))) : toppin.y), toppin.scale, toppin.scale, toppin.angle, c_white, 1)
                pattern_reset()
                shader_reset()
            }
        }
        break
    case 1:
        draw_sprite_ext(rat.sprite_index, 0, (rat.x + (irandom_range(-1, 1))), (rat.y + (irandom_range(-1, 1))), rat.scale, rat.scale, 0, c_white, 1)
        break
    case 2:
        draw_sprite_ext(rat.sprite_index, _image_index, rat.x, rat.y, rat.scale, rat.scale, 0, c_white, 1)
        break
}

if (state == (0 << 0))
    draw_sprite(cursor_spr, image_index, (display_mouse_get_x() - sprite_get_width(cursor_spr) * 2.6), (display_mouse_get_y() - sprite_get_height(cursor_spr) * 1.4))
if (state == 1)
    draw_sprite_ext(spr_uparrow, 0, rat.x, (rat.y - 150), 2, -2, 0, c_white, 1)

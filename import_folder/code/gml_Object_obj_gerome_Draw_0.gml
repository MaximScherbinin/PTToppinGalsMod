draw_self()

if (global.mod_partyhat)
    draw_sprite_ext(spr_toppinspartyhat, 0, x, (y - (sprite_get_height(sprite_index) * 0.25)) + lengthdir_y(5, current_time * 0.1), image_xscale, image_yscale, image_angle, image_blend, image_alpha)

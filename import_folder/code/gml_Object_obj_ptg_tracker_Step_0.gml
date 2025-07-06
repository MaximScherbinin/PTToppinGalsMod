if (room == tower_ptgextrasroom)
{
    var lay_id = layer_get_id("Backgrounds_scroll")
    var cam_x = camera_get_view_x(view_camera[0])
    var cam_y = camera_get_view_y(view_camera[0])
    camera_set_view_pos(view_camera[0], floor(cam_x), floor(cam_y))
    var lay_x = layer_get_x(lay_id)
    var lay_y = layer_get_y(lay_id)
    layer_x(lay_id, floor(lay_x))
    layer_y(lay_id, floor(lay_y))
}

if (variable_global_exists("mod_femgerome"))
{
    if (global.mod_femgerome)
    {
        if (instance_exists(obj_johnresurrection_gerome))
        {
            with (obj_johnresurrection_gerome)
            {
                if (sprite_index == spr_johnresurrected_gerome1)
                    sprite_index = spr_johnresurrected_femgerome1
                
                if (sprite_index == spr_johnresurrected_gerome2)
                    sprite_index = spr_johnresurrected_femgerome2
                
                if (sprite_index == spr_johnresurrected_gerome3)
                    sprite_index = spr_johnresurrected_femgerome3
            }
        }
    }
}

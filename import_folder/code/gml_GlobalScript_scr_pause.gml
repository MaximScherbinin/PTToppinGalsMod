function scr_pauseicon_draw(arg0, arg1, arg2)
{
    var icon = pause_icons[arg0]
    draw_sprite_ext(global.mod_femgerome ? spr_pauseicons_femgerome : icon.sprite_index, icon.image_index, arg1 + icon.sprite_xoffset + icon.shake_x, arg2 + icon.sprite_yoffset + icon.shake_y, 1, 1, 0, c_white, icon.image_alpha)
}

function scr_create_pause_image()
{
    draw_set_alpha(1)
    screensprite = sprite_create_from_surface(application_surface, 0, 0, surface_get_width(application_surface), surface_get_height(application_surface), false, false, 0, 0)
    guisprite = sprite_create_from_surface(obj_screensizer.gui_surf, 0, 0, surface_get_width(obj_screensizer.gui_surf), surface_get_height(obj_screensizer.gui_surf), false, false, 0, 0)
    screenscale = min(obj_screensizer.actual_width / surface_get_width(application_surface), obj_screensizer.actual_height / surface_get_height(application_surface))
}

function scr_draw_pause_image()
{
    draw_rectangle_color(0, 0, obj_screensizer.actual_width, obj_screensizer.actual_height, c_black, c_black, c_black, c_black, false)
    draw_sprite_ext(screensprite, 0, 0, 0, screenscale, screenscale, 0, c_white, 1)
    draw_sprite_ext(guisprite, 0, 0, 0, 1, 1, 0, c_white, 1)
}

function scr_pause_stop_sounds()
{
    fmod_event_instance_stop(global.snd_alarm, true)
    fmod_event_instance_stop(global.snd_bossbeaten, true)
    fmod_event_instance_stop(global.snd_spaceship, true)
    fmod_event_instance_stop(global.snd_escaperumble, true)
    fmod_event_instance_stop(global.snd_johndead, true)
}

function scr_delete_pause_image()
{
    if (sprite_exists(screensprite))
        sprite_delete(screensprite)
    
    if (sprite_exists(guisprite))
        sprite_delete(guisprite)
}

function scr_pauseicon_add(arg0, arg1, arg2 = 0, arg3 = 0)
{
    array_push(pause_icons, 
    {
        sprite_index: arg0,
        image_index: arg1,
        image_alpha: 0,
        sprite_xoffset: arg2,
        sprite_yoffset: arg3,
        shake_x: 0,
        shake_y: 0
    })
}

function scr_pauseicons_update(arg0)
{
    for (var i = 0; i < array_length(pause_icons); i++)
    {
        with (pause_icons[i])
        {
            if (i == arg0)
            {
                shake_x = random_range(-1, 1)
                shake_y = random_range(-1, 1)
                image_alpha = Approach(image_alpha, 1, 0.2)
            }
            else
            {
                shake_x = 0
                shake_y = 0
                image_alpha = Approach(image_alpha, 0, 0.2)
            }
        }
    }
}

function scr_pause_activate_objects(arg0 = true)
{
    for (var i = 0; i < ds_list_size(instance_list); i++)
        instance_activate_object(ds_list_find_value(instance_list, i))
    
    if (arg0)
    {
        for (var i = 0; i < ds_list_size(sound_list); i++)
            fmod_event_instance_set_paused(ds_list_find_value(sound_list, i), false)
        
        fmod_event_instance_set_paused_all(false)
    }
    
    ds_list_clear(instance_list)
    ds_list_clear(sound_list)
    fadein = false
    pause = false
    alarm[2] = 1
}

function scr_pause_deactivate_objects(arg0 = true)
{
    if (arg0)
        fmod_event_instance_set_paused_all(true)
    
    ds_list_clear(instance_list)
    
    for (var i = 0; i < instance_count; i++)
    {
        var obj = instance_find(-3, i)
        
        if (instance_exists(obj) && obj.object_index != obj_pause && obj.object_index != obj_inputAssigner && obj.object_index != obj_screensizer)
            ds_list_add(instance_list, obj)
    }
    
    instance_deactivate_all(true)
    instance_activate_object(obj_inputAssigner)
    instance_activate_object(obj_savesystem)
    instance_activate_object(obj_pause)
    instance_activate_object(obj_screensizer)
    instance_activate_object(obj_music)
    instance_activate_object(obj_fmod)
    instance_activate_object(obj_globaltimer)
}

function pause_spawn_priests()
{
    var p = 
    {
        x: 0,
        y: obj_screensizer.actual_height + 200,
        speed: random_range(0.8, 1.4),
        image_index: 0,
        image_speed: 0.35,
        image_xscale: choose(-1, 1),
        image_alpha: 0,
        sprite_index: choose(spr_angelpriest, spr_angelpriest2, spr_angelpriest3)
    }
    
    if (is_holiday(holidays.halloween))
        p.sprite_index = choose(spr_pepbat_move, spr_ghostshroom, spr_ghoul_idle)
    
    var q = irandom(100)
    
    if (q >= 50)
        p.x = irandom_range(obj_screensizer.actual_width * 0.78, obj_screensizer.actual_width * 0.65)
    else
        p.x = irandom_range(obj_screensizer.actual_width * 0.2, 0.42)
    
    ds_list_add(priest_list, p)
}

function pause_unpause_music()
{
    with (obj_music)
    {
        if (music != -4)
        {
            fmod_event_instance_set_paused(music.event, other.savedmusicpause)
            fmod_event_instance_set_paused(music.event_secret, other.savedsecretpause)
        }
        
        fmod_event_instance_set_paused(pillarmusicID, other.savedpillarpause)
        fmod_event_instance_set_paused(panicmusicID, other.savedpanicpause)
        fmod_event_instance_set_paused(kidspartychaseID, other.savedkidspartypause)
    }
    
    fmod_event_instance_stop(pausemusicID, true)
}

function pause_update_priests()
{
    for (var i = 0; i < ds_list_size(priest_list); i++)
    {
        var b = ds_list_find_value(priest_list, i)
        var destroy = false
        
        with (b)
        {
            y -= speed
            image_index += image_speed
            
            if (!other.pause)
                x += ((x > (obj_screensizer.actual_width / 2)) ? 10 : -10)
            
            if (y < -200)
                destroy = true
            
            var a = 0.02
            
            if (y > 250)
            {
                if (y < (obj_screensizer.actual_height - 100))
                    image_alpha += a
            }
            else
            {
                image_alpha -= a
            }
        }
        
        if (destroy)
        {
            b = undefined
            ds_list_delete(priest_list, i--)
        }
    }
}

function pause_draw_priests()
{
    for (var i = 0; i < ds_list_size(priest_list); i++)
    {
        var b = ds_list_find_value(priest_list, i)
        
        with (b)
            draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, 1, 0, c_white, image_alpha)
    }
}

enum holidays
{
    normal,
    halloween
}

if (object_index == obj_stickfollower || object_index == obj_gustavofollower || object_index == obj_noisefollower)
    return;
if ((!other.ispeppino) || global.swapmode)
{
    var t = other.id
    fmod_event_one_shot_3d("event:/sfx/enemies/kill", x, y)
    notification_push((2 << 0), [room, id, object_index])
    ds_list_add(global.baddieroom, id)
    global.combotime = 60
    if (object_index == obj_toppinshroomexit || object_index == obj_toppincheeseexit || object_index == obj_toppintomatoexit || object_index == obj_toppinsausageexit || object_index == obj_toppinpineappleexit)
    {
        with (create_debris(x, (y - 32), spr_cagedebris, 0))
            image_index = 0
        with (create_debris(x, (y + 32), spr_cagedebris, 0))
            image_index = 1
        with (create_debris((x - 10), y, spr_cagedebris, 0))
            image_index = 2
        with (create_debris(x, y, spr_cagedebris, 0))
            image_index = 3
        with (create_debris((x + 10), y, spr_cagedebris, 0))
            image_index = 4
        fmod_event_one_shot_3d("event:/misc/breakblock", x, y)
    }
    instance_create(x, y, obj_bangeffect)
    instance_create(x, y, obj_genericpoofeffect)
    with (instance_create(x, y, obj_sausageman_dead))
    {
        if (other.object_index == obj_fakepepfollower)
        {
            use_palette = 1
            spr_palette = spr_peppalette
            paletteselect = 1
            if obj_player1.ispeppino
                paletteselect = obj_player1.paletteselect
        }
        else if (other.object_index == obj_snottyexit)
        {
            use_palette = 1
            spr_palette = palette_cheeseslime
            paletteselect = 1
        }
        if other.use_palette
        {
            use_palette = 1
            paletteselect = other.paletteselect
            spr_palette = other.spr_palette
            oldpalettetexture = other.palettetexture
        }
        if (t.state == (306 << 0) && t.hsp != 0)
            image_xscale = (-sign(hsp))
        else
            image_xscale = (-t.xscale)
        sprite_index = other.spr_dead
        hsp = (-image_xscale) * 10
    }
    instance_destroy(id, 0)
}

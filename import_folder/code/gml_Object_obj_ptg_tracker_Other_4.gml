if (!variable_global_exists("mod_graceball"))
    return;
if (!variable_global_exists("mod_femgerome"))
    return;
if (room == tower_finalhallway || room == Mainmenu)
{
	global.exit_toppin_shroom = 0
	global.exit_toppin_cheese = 0
	global.exit_toppin_tomato = 0
	global.exit_toppin_sausage = 0
	global.exit_toppin_pineapple = 0
}
if (room == tower_entrancehall && global.panic) {
	var lay_id = layer_get_id("Assets_1")
	layer_set_visible(lay_id, 0)
}
if (room == Endingroom)
{
	if global.exit_toppin_shroom
	{
		with (instance_create(0, 0, obj_introprop))
		{
			image_speed = 0
			sprite_index = spr_towerending_toppins
			image_index = 0
			depth = -8
		}
	}
	if global.exit_toppin_cheese
	{
		with (instance_create(0, 0, obj_introprop))
		{
			image_speed = 0
			sprite_index = spr_towerending_toppins
			image_index = 1
			depth = -8
		}
	}
	if global.exit_toppin_tomato
	{
		with (instance_create(0, 0, obj_introprop))
		{
			image_speed = 0
			sprite_index = spr_towerending_toppins
			image_index = 2
			depth = -8
		}
	}
	if global.exit_toppin_sausage
	{
		with (instance_create(0, 0, obj_introprop))
		{
			image_speed = 0
			sprite_index = spr_towerending_toppins
			image_index = 3
			depth = -8
		}
	}
	if global.exit_toppin_pineapple
	{
		with (instance_create(0, 0, obj_introprop))
		{
			image_speed = 0
			sprite_index = spr_towerending_toppins
			image_index = 4
			depth = -8
		}
	}
}
if (room == Creditsroom)
{
	ini_open_from_string(obj_savesystem.ini_str)
	if (global.exit_toppin_shroom && global.exit_toppin_cheese && global.exit_toppin_tomato && global.exit_toppin_sausage && global.exit_toppin_pineapple)
		ini_write_real("Game", "toppingals", 1)
	obj_savesystem.ini_str = ini_close()
	gamesave_async_save()
}
if (room == tower_escape3) && global.exit_toppin_shroom == 0
	instance_create(4278, 576, obj_toppinshroomexit)
if (room == tower_escape4) && global.exit_toppin_cheese == 0
	instance_create(7168, 768, obj_toppincheeseexit)
if (room == tower_escape6) && global.exit_toppin_tomato == 0
	instance_create(1024, 384, obj_toppintomatoexit)
if (room == tower_escape7) && global.exit_toppin_sausage == 0
	instance_create(5580, 992, obj_toppinsausageexit)
if (room == tower_2) && global.exit_toppin_pineapple == 0
	instance_create(5549, 448, obj_toppinpineappleexit)

with(obj_achievementviewer) {
	if global.mod_graceball {
		if (achievement = "minigolf1" || achievement = "minigolf2")
			sprite_index = spr_achievement_golf_grace
	}
}

with(obj_PTG) {
	sprite_index = (global.mod_pizzatowergal == 1 ? spr_PTG_monstoppinanon : spr_PTG_femgeromeanon)
	if is_holiday((1 << 0))
		sprite_index = (global.mod_pizzatowergal == 0 ? spr_PTGhalloween_femgeromeanon : spr_PTGhalloween)
}

with(obj_golfhoop) {
	if global.mod_graceball
		sprite_index = spr_golfhoop_grace
}

with(obj_ghosthazard) {
	image_speed = 0.35
}


if (room == plage_cavern2)
{
    var lay_id = layer_get_id("Assets_1")
    var arr_l = layer_get_all_elements(lay_id)
    var sprite_i = arr_l[4]
    var _spr_ptg = (global.mod_pizzatowergal == 1 ? PTGbeach_monstoppinanon : PTGbeach_femgeromeanon)
    layer_sprite_change(sprite_i, _spr_ptg)
}
if (room == tower_mansion)
{
    lay_id = layer_create(90, "Assets_1")
    var spr = spr_tile_mansion_geromeshroom
    layer_sprite_create(lay_id, 1192, 393, spr)
    if global.mod_graceball
    {
        spr = spr_tile_mansion_graceco
        layer_sprite_create(lay_id, 1201, 174, spr)
        lay_id = layer_get_id("Tiles_4")
        spr = spr_tile_mansion_graceballstatue
        var map_id = layer_tilemap_get_id(lay_id)
        var spr_h = sprite_get_height(spr)
        var spr_w = sprite_get_width(spr)
        for (var yy = 448; yy < (448 + spr_h); yy += 8)
        {
            for (var xx = 480; xx < (480 + spr_w); xx += 8)
            {
                var data = tilemap_get_at_pixel(map_id, xx, yy)
                data = tile_set_empty(data)
                tilemap_set_at_pixel(map_id, data, xx, yy)
            }
        }
        layer_sprite_create(lay_id, 480, 448, spr)
    }
}
if global.mod_femgerome
{
    if (room == saloon_2b && (!global.panic))
    {
        lay_id = layer_get_id("Backgrounds_still1")
        var back_id = layer_background_get_id(lay_id)
        layer_background_sprite(back_id, bg_saloonalt_femgerome)
    }
    if (room == saloon_3b)
    {
        lay_id = layer_get_id("Backgrounds_still1")
        back_id = layer_background_get_id(lay_id)
        layer_background_sprite(back_id, bg_saloonalt_femgerome)
    }
    if (room == saloon_4b)
    {
        lay_id = layer_get_id("Backgrounds_still1")
        back_id = layer_background_get_id(lay_id)
        layer_background_sprite(back_id, bg_saloonalt_femgerome)
    }
    if (room == saloon_5b)
    {
        lay_id = layer_get_id("Backgrounds_still1")
        back_id = layer_background_get_id(lay_id)
        layer_background_sprite(back_id, bg_saloonalt_femgerome)
    }
    if (room == saloon_6b)
    {
        lay_id = layer_get_id("Backgrounds_still1")
        back_id = layer_background_get_id(lay_id)
        layer_background_sprite(back_id, bg_saloonalt_femgerome)
    }
}
if global.mod_graceball
{
    if (room == plage_beach1)
    {
        lay_id = layer_create(90, "Assets_3")
        spr = spr_tile_beach_graceball
        layer_sprite_create(lay_id, 8161, 266, spr)
    }
    if (room == plage_beach2)
    {
        lay_id = layer_create(90, "Assets_2")
        spr = spr_tile_beach_graceball
        layer_sprite_create(lay_id, 7585, 554, spr)
    }
    if (room == minigolf_1)
    {
        lay_id = layer_get_id("Backgrounds_1")
        back_id = layer_background_get_id(lay_id)
        layer_background_sprite(back_id, bg_golfads_grace)
    }
    if (room == minigolf_2)
    {
        lay_id = layer_get_id("Backgrounds_1")
        back_id = layer_background_get_id(lay_id)
        layer_background_sprite(back_id, bg_golfads_grace)
    }
    if (room == minigolf_4)
    {
        lay_id = layer_get_id("Backgrounds_1")
        back_id = layer_background_get_id(lay_id)
        layer_background_sprite(back_id, bg_golfads_grace)
    }
    if (room == minigolf_5)
    {
        lay_id = layer_get_id("Backgrounds_still1")
        back_id = layer_background_get_id(lay_id)
        layer_background_sprite(back_id, bg_minigolf3_grace)
        lay_id = layer_get_id("Backgrounds_scroll")
        back_id = layer_background_get_id(lay_id)
        layer_background_sprite(back_id, bg_golfclouds_grace)
    }
    if (room == minigolf_6)
    {
        lay_id = layer_get_id("Backgrounds_still1")
        back_id = layer_background_get_id(lay_id)
        layer_background_sprite(back_id, bg_minigolf3_grace)
        lay_id = layer_get_id("Backgrounds_scroll")
        back_id = layer_background_get_id(lay_id)
        layer_background_sprite(back_id, bg_golfclouds_grace)
    }
    if (room == minigolf_7)
    {
        lay_id = layer_get_id("Backgrounds_still1")
        back_id = layer_background_get_id(lay_id)
        layer_background_sprite(back_id, bg_minigolf3_grace)
        lay_id = layer_get_id("Backgrounds_scroll")
        back_id = layer_background_get_id(lay_id)
        layer_background_sprite(back_id, bg_golfclouds_grace)
    }
    if (room == minigolf_8)
    {
        lay_id = layer_get_id("Backgrounds_zigzag1")
        back_id = layer_background_get_id(lay_id)
        layer_background_sprite(back_id, bg_golfballoon_grace)
        lay_id = layer_get_id("Backgrounds_still1")
        back_id = layer_background_get_id(lay_id)
        layer_background_sprite(back_id, bg_minigolf4_grace)
    }
    if (room == minigolf_9)
    {
        lay_id = layer_get_id("Backgrounds_zigzag1")
        back_id = layer_background_get_id(lay_id)
        layer_background_sprite(back_id, bg_golfballoon_grace)
        lay_id = layer_get_id("Backgrounds_still1")
        back_id = layer_background_get_id(lay_id)
        layer_background_sprite(back_id, bg_minigolf4_grace)
    }
    if (room == minigolf_10)
    {
        lay_id = layer_get_id("Backgrounds_zigzag1")
        back_id = layer_background_get_id(lay_id)
        layer_background_sprite(back_id, bg_golfballoon_grace)
        lay_id = layer_get_id("Backgrounds_still1")
        back_id = layer_background_get_id(lay_id)
        layer_background_sprite(back_id, bg_minigolf4_grace)
    }
    if (room == minigolf_11)
    {
        lay_id = layer_get_id("Backgrounds_zigzag1")
        back_id = layer_background_get_id(lay_id)
        layer_background_sprite(back_id, bg_golfballoon_grace)
        lay_id = layer_get_id("Backgrounds_still1")
        back_id = layer_background_get_id(lay_id)
        layer_background_sprite(back_id, bg_minigolf4_grace)
    }
    if (room == freezer_5)
    {
        lay_id = layer_get_id("Backgrounds_still1")
        back_id = layer_background_get_id(lay_id)
        layer_background_sprite(back_id, Bg_freezerfridge_grace)
    }
    if (room == freezer_6)
    {
        lay_id = layer_get_id("Backgrounds_still1")
        back_id = layer_background_get_id(lay_id)
        layer_background_sprite(back_id, Bg_freezerfridge_grace)
    }
    if (room == freezer_7)
    {
        lay_id = layer_get_id("Backgrounds_still1")
        back_id = layer_background_get_id(lay_id)
        layer_background_sprite(back_id, Bg_freezerfridge_grace)
    }
    if (room == freezer_9)
    {
        lay_id = layer_get_id("Backgrounds_still1")
        back_id = layer_background_get_id(lay_id)
        layer_background_sprite(back_id, Bg_freezerfridge_grace)
    }
}

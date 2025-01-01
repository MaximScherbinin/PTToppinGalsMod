scr_tg_vars_init() {
	var _Nfinished = 0
	var data_arr = [(get_save_folder() + "/saveData1"), (get_save_folder() + "/saveData2"), (get_save_folder() + "/saveData3")]
	for (var i = 0; i < array_length(data_arr); i++)
	{
		var n_save = []
		n_save[i] = scr_read_game(data_arr[i] + "N.ini")
		if (n_save[i].judgement != "none")
			_Nfinished = 1
	}
	if (!variable_global_exists("mod_femgerome"))
		global.mod_femgerome = 0
	else if (_Nfinished == 0)
		global.mod_femgerome = 0
	global.mod_pizzagal = 0
	global.mod_grannyhuman = 0
	global.mod_graceball = 0
	global.mod_pizzatowergal = 0
	global.mod_partyhat = 0
	global.mod_spr_pizzaface = spr_pizzaface
	global.mod_spr_timer_pizzaface1 = spr_timer_pizzaface1
	global.mod_spr_timer_pizzaface2 = spr_timer_pizzaface2
	global.mod_spr_timer_pizzaface3 = spr_timer_pizzaface3
	global.mod_spr_pizzaface_intro1 = spr_pizzaface_intro1
	global.mod_spr_pizzaface_intro2 = spr_pizzaface_intro2
	global.mod_spr_pizzaface_nosespit1 = spr_pizzaface_nosespit1
	global.mod_spr_pizzaface_nosespit2 = spr_pizzaface_nosespit2
	global.mod_spr_pizzaface_nosespit3 = spr_pizzaface_nosespit3
	global.mod_spr_pizzaface_attackstart = spr_pizzaface_attackstart
	global.mod_spr_pizzaface_attack = spr_pizzaface_attack
	global.mod_spr_pizzaface_attackland = spr_pizzaface_attackland
	global.mod_spr_pizzaface_attackend = spr_pizzaface_attackend
	global.mod_spr_pizzaface_attackjump = spr_pizzaface_attackjump
	global.mod_spr_pizzaface_stun = spr_pizzaface_stun
	global.mod_spr_pizzaface_hurt = spr_pizzaface_hurt
	global.mod_spr_pizzahead_intro1 = spr_pizzahead_intro1
	global.mod_spr_pizzahead_intro2 = spr_pizzahead_intro2
}
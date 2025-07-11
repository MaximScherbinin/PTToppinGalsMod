currentselect = 0
optionbuffer = 0
visualselect = 0
state = states.titlescreen
image_speed = 0.35
depth = 0
mainmenu_sprite = -1
controls_sprite = -1
angrybuffer = 0
savedsprite = -4
savedindex = 0
deleteselect = 1
exitselect = 1
percvisual = 0
taunt_key = scr_compile_icon_text("[x]")
grab_key = scr_compile_icon_text("[q]")
start_key = scr_compile_icon_text("[p]")
jumpscarecount = 0
quitbuffer = 0
vsp = 0
shownoise = false
showswap = false
charselect = 0
showbuffer_max = 300
john = true
snotty = true
toppingals = true
judgement = "confused"
deletebuffer = 0
obj_player1.player_paletteselect[0] = 1
obj_player1.player_paletteselect[1] = 1
percentage = 0
perstatus_icon = 0
extrauialpha = 0
punch_x = 0
punch_y = 0
key_jump = false
index = 0
bombsnd = fmod_event_create_instance("event:/sfx/ui/bombfuse")
scr_init_input()
pep_game = -4
pep_percvisual = 0
pep_alpha = 1
noise_game = -4
noise_percvisual = 0
noise_alpha = 0
noise_unlocked = false
pep_debris = false
swap_unlocked = false
game_icon_y = 0
game_icon_buffer = 0
game_icon_index = 0
punch_count = 0
unlock_noise = function(argument0) //gml_Script_anon_gml_Object_obj_mainmenu_Create_0_1215_gml_Object_obj_mainmenu_Create_0
{
    var i = 0
    while (i < 3)
    {
        if (global.game[i].judgement != "none" || global.gameN[i].judgement != "none")
        {
            argument0 = true
            break
        }
        else
            i++
    }
    if (!argument0)
    {
        ini_open_from_string(obj_savesystem.ini_str_options)
        argument0 = ini_read_real("Game", "beaten", 0) > 0
        if (!argument0)
            argument0 = ini_read_real("Game", "noiseunlocked", 0)
        ini_close()
    }
    if argument0
    {
        noise_unlocked = true
        ini_open_from_string(obj_savesystem.ini_str_options)
        if (ini_read_real("Game", "noiseunlocked", 0) == 0)
        {
            instance_create(0, 0, obj_noiseunlocked)
            ini_write_real("Game", "noiseunlocked", 1)
            obj_savesystem.ini_str_options = ini_close()
            gamesave_async_save_options()
        }
        else
            ini_close()
    }
}

unlock_swap = function(argument0) //gml_Script_anon_gml_Object_obj_mainmenu_Create_0_2036_gml_Object_obj_mainmenu_Create_0
{
    var i = 0
    while (i < 3)
    {
        if (global.gameN[i].judgement != "none")
        {
            argument0 = true
            break
        }
        else
            i++
    }
    if (!argument0)
    {
        ini_open_from_string(obj_savesystem.ini_str_options)
        argument0 = ini_read_real("Game", "swapunlocked", 0)
        ini_close()
    }
    if argument0
    {
        swap_unlocked = true
        ini_open_from_string(obj_savesystem.ini_str_options)
        if (ini_read_real("Game", "swapunlocked", 0) == 0)
        {
            with (instance_create(0, 0, obj_noiseunlocked))
                sprite_index = spr_swapmodeunlocked
            ini_write_real("Game", "swapunlocked", 1)
            obj_savesystem.ini_str_options = ini_close()
            gamesave_async_save_options()
        }
        else
            ini_close()
    }
}

self.unlock_noise(false)
ini_open_from_string(obj_savesystem.ini_str_options)
swap_unlocked = ini_read_real("Game", "swapmode", 0) == 1
ini_close()

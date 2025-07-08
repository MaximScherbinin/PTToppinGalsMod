function tv_set_idle() //gml_Script_tv_set_idle
{
    with (obj_tv)
    {
        state = states.normal
        sprite_index = spr_tv_idle
    }
}

function tv_reset() //gml_Script_tv_reset
{
    with (obj_tv)
    {
        state = states.normal
        sprite_index = spr_tv_idle
        ds_list_clear(tvprompts_list)
    }
}

function tv_create_prompt(argument0, argument1, argument2, argument3) //gml_Script_tv_create_prompt
{
    return [argument0, argument1, argument2, argument3];
}

function tv_push_prompt(argument0, argument1, argument2, argument3) //gml_Script_tv_push_prompt
{
    with (obj_tv)
    {
        var b = [argument0, argument1, argument2, argument3]
        var play = false
        switch argument1
        {
            case (0 << 0):
                play = true
                ds_list_insert(tvprompts_list, 0, b)
                break
            case (1 << 0):
                var placed = false
                var i = 0
                while (i < ds_list_size(tvprompts_list))
                {
                    var b2 = ds_list_find_value(tvprompts_list, i)
                    if (b2[1] == (2 << 0))
                    {
                        if (i == 0)
                            play = true
                        ds_list_insert(tvprompts_list, i, b)
                        placed = true
                        break
                    }
                    else
                        i++
                }
                if (!placed)
                    ds_list_add(tvprompts_list, b)
                break
            case (2 << 0):
                ds_list_add(tvprompts_list, b)
                break
        }

        if play
            state = states.normal
    }
}

function tv_push_prompt_array(argument0) //gml_Script_tv_push_prompt_array
{
    for (var i = 0; i < array_length(argument0); i++)
    {
        with (obj_tv)
        {
            var b = argument0[i]
            tv_push_prompt(b[0], b[1], b[2], b[3])
        }
    }
}

function tv_push_prompt_once(argument0, argument1) //gml_Script_tv_push_prompt_once
{
    with (obj_tv)
    {
        if (special_prompts == -4)
            return false;
        var b = ds_map_find_value(special_prompts, argument1)
        if is_undefined(b)
            return false;
        if (b != 1)
        {
            tv_push_prompt(argument0[0], argument0[1], argument0[2], argument0[3])
            ds_map_set(special_prompts, argument1, 1)
            ini_open_from_string(obj_savesystem.ini_str)
            ini_write_real("Prompts", argument1, 1)
            obj_savesystem.ini_str = ini_close()
            return true;
        }
        return false;
    }
}

function tv_default_condition() //gml_Script_tv_default_condition
{
    return place_meeting(x, y, obj_player);
}

function tv_get_palette() //gml_Script_tv_get_palette
{
    if (!instance_exists(obj_player1))
        return;
    var _info = (obj_player1.ispeppino ? get_pep_palette_info() : get_noise_palette_info())
    spr_palette = _info.spr_palette
    if (obj_player1.isgustavo && obj_player1.ispeppino)
        spr_palette = spr_ratmountpalette
    paletteselect = _info.paletteselect
    patterntexture = _info.patterntexture
}

function tv_do_expression(argument0, argument1, argument2) //gml_Script_tv_do_expression
{
    if (argument1 == undefined)
        argument1 = false
    if (argument2 == undefined)
        argument2 = false
    with (obj_tv)
    {
        if (expressionsprite != argument0 && bubblespr == -4)
        {
            state = (250 << 0)
            expressionsprite = argument0
            switch expressionsprite
            {
                case spr_tv_exprhurt:
                case spr_tv_exprhurtN:
                case spr_tv_hurtG:
                    expressionbuffer = 60
                    break
                case spr_tv_exprhurt1:
                case spr_tv_exprhurt2:
                case spr_tv_exprhurt3:
                case spr_tv_exprhurt4:
                case spr_tv_exprhurt5:
                case spr_tv_exprhurt6:
                case spr_tv_exprhurt7:
                case spr_tv_exprhurt8:
                case spr_tv_exprhurt9:
                case spr_tv_exprhurt10:
                case spr_tv_exprhurtN1:
                case spr_tv_exprhurtN2:
                case spr_tv_exprhurtN3:
                case spr_tv_exprhurtN4:
                case spr_tv_exprhurtN5:
                case spr_tv_exprhurtN6:
                case spr_tv_exprhurtN7:
                case spr_tv_exprhurtN8:
                case spr_tv_exprhurtN9:
                case spr_tv_exprhurtN10:
                case spr_tv_toppinshroom:
                case spr_tv_toppincheese:
                case spr_tv_toppintomato:
                case spr_tv_toppinsausage:
                case spr_tv_toppinpineapple:
                    expressionbuffer = 100
                    break
                case spr_tv_exprcollect:
                    expressionbuffer = 150
                    if obj_player.isgustavo
                    {
                        expressionsprite = spr_tv_happyG
                        if (irandom(100) <= 50)
                            fmod_event_one_shot_3d("event:/sfx/voice/brickok", obj_player1.x, obj_player1.y)
                    }
                    if (irandom(100) <= 50)
                        scr_fmod_soundeffect(obj_player1.snd_voiceok, obj_player1.x, obj_player1.y)
                    break
            }

            if ((!argument2) && instance_exists(obj_player1) && (!obj_player1.ispeppino))
            {
                var n = asset_get_index(sprite_get_name(argument0) + "N")
                if (n > -1)
                    expressionsprite = n
            }
            if argument1
                reset_palette = true
            else
                reset_palette = false
        }
    }
}

function scr_tv_get_transfo_sprite() //gml_Script_scr_tv_get_transfo_sprite
{
    var _state = obj_player1.state
    if (_state == states.backbreaker || _state == states.chainsaw)
        _state = obj_player1.tauntstoredstate
    var _spr = -4
    if instance_exists(obj_bucketfollower)
        _spr = spr_tv_bucket
    switch _state
    {
        case states.knightpep:
        case states.knightpepattack:
        case states.knightpepbump:
        case states.knightpepslopes:
            _spr = spr_tv_knight
            break
        case states.bombpep:
        case states.bombgrab:
            _spr = spr_tv_bombpep
            break
        case states.fireass:
            _spr = spr_tv_fireass
            if (obj_player1.sprite_index == obj_player1.spr_scaredjump1 || obj_player1.sprite_index == obj_player1.spr_scaredjump2)
                _spr = spr_tv_scaredjump
            break
        case states.tumble:
            if (obj_player1.sprite_index == obj_player1.spr_tumble || obj_player1.sprite_index == obj_player1.spr_tumblestart || obj_player1.sprite_index == obj_player1.spr_tumbleend)
                _spr = spr_tv_tumble
            else if obj_player1.shotgunAnim
                _spr = spr_tv_shotgun
            break
        case states.firemouth:
            _spr = spr_tv_firemouth
            break
        case states.ghost:
        case states.ghostpossess:
            _spr = spr_tv_ghost
            break
        case states.stunned:
            if (obj_player1.sprite_index == obj_player1.spr_squished)
                _spr = spr_tv_squished
            break
        case states.normal:
        case states.jump:
        case states.handstandjump:
        case states.crouch:
        case states.ladder:
        case states.mach3:
        case states.machslide:
        case states.bump:
            with (obj_player1)
            {
                if shotgunAnim
                    _spr = spr_tv_shotgun
                else if global.mort
                    _spr = spr_tv_mort
            }
            break
        case states.freefallprep:
        case states.freefall:
        case states.freefallland:
            if obj_player1.shotgunAnim
                _spr = spr_tv_shotgun
            break
        case states.pistol:
            if global.mort
                _spr = spr_tv_mort
            break
        case states.shotgun:
        case states.shotgunshoot:
        case states.shotgunfreefall:
        case states.shotgunjump:
        case states.shotgundash:
        case states.shotguncrouch:
        case states.shotguncrouchjump:
            _spr = spr_tv_shotgun
            break
        case states.barrel:
        case states.barreljump:
        case states.barrelslide:
        case states.barrelclimbwall:
            _spr = spr_tv_barrel
            break
        case states.golf:
            _spr = (global.mod_graceball ? spr_tv_golf_grace : spr_tv_golf)
            break
        case states.rocket:
        case states.rocketslide:
            _spr = spr_tv_rocket
            break
        case states.cheeseball:
            _spr = spr_tv_cheeseball
            break
        case states.cheesepep:
        case states.cheesepepjump:
        case states.cheesepepstick:
        case states.cheesepepstickside:
        case states.cheesepepstickup:
            _spr = spr_tv_cheesepep
            break
        case states.boxxedpep:
        case states.boxxedpepjump:
        case states.boxxedpepspin:
            _spr = spr_tv_boxxedpep
            break
        case states.rideweenie:
            _spr = spr_tv_weenie
            break
        case states.mort:
        case states.mortattack:
        case states.morthook:
        case states.mortjump:
            _spr = spr_tv_mort
            break
        case states.mach2:
        case states.climbwall:
        case states.machroll:
        case states.grind:
            if obj_player1.skateboarding
                _spr = spr_tv_clown
            else if obj_player1.shotgunAnim
                _spr = spr_tv_shotgun
            break
    }

    with (obj_player1)
    {
        if (state == states.actor && sprite_index == spr_tumble)
            _spr = spr_tv_tumble
    }
    return _spr;
}


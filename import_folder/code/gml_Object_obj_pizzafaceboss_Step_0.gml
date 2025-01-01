targetplayer = obj_player1.id
wastedhits = 8 - elitehit
destroyable = 0
switch state
{
    case (144 << 0):
        scr_pizzaface_arenaintro()
        break
    case (134 << 0):
        scr_pizzaface_normal()
        break
    case (230 << 0):
        scr_pizzaface_ram()
        break
    case (8 << 0):
        scr_pizzaface_transitioncutscene()
        break
    case (273 << 0):
        lasthit = 1
        scr_boss_phase1hurt()
        sprite_index = global.mod_spr_pizzaface_hurt
        image_speed = 0.35
        break
    case (137 << 0):
        scr_enemy_hit()
        break
    case (138 << 0):
        scr_enemy_stun()
        break
    case (4 << 0):
        scr_boss_grabbed()
        break
    case (154 << 0):
        scr_enemy_pummel()
        break
    case (155 << 0):
        scr_enemy_staggered()
        break
}

if (superslambuffer > 0)
    superslambuffer--
if (state != (134 << 0))
    on_y = 1
if (prevhp != elitehit)
{
    if (elitehit < prevhp)
    {
        baddie_range++
        cooldown = 0
        attackbuffer = 0
        touchedground = 0
        hsp += ((-image_xscale) * 5)
        flickertime = 11
        attackbuffer += 40
        on_y = 0
        alarm[6] = 5
        global.playerhit++
        if (global.playerhit >= 3)
        {
            global.playerhit = 0
            instance_create(obj_player1.x, -15, obj_hppickup)
        }
        if (elitehit <= 0)
        {
            with (obj_music)
                fmod_event_instance_set_parameter(music.event, "state", 1, 1)
            instance_destroy(obj_forkhitbox)
            instance_destroy(obj_spitcheesespike)
            instance_destroy(obj_banditochicken_dynamite)
            instance_destroy(obj_banditochicken_projectile)
            state = (8 << 0)
            substate = (293 << 0)
            introbuffer = 100
            flickertime = 0
            elitehit = 0
            on_y = 1
            image_alpha = 1
            with (instance_create(0, 0, obj_pizzahead_whitefade))
                deccel = 0.1
            with (obj_player1)
            {
                hsp = 0
                vsp = 0
                xscale = 1
                movespeed = 0
                image_index = 0
                sprite_index = spr_player_gnomecutscene1
                if (!ispeppino)
                    sprite_index = spr_noisebossintro2
                image_speed = 0.35
                state = (146 << 0)
                x = roomstartx
                y = roomstarty
            }
            x = room_width / 2
            y = obj_player1.y - 100
            sprite_index = global.mod_spr_pizzahead_intro1
            with (obj_baddie)
            {
                if (object_index != obj_pizzafaceboss && object_index != obj_pizzafaceboss_p2)
                    instance_destroy()
            }
        }
    }
    prevhp = elitehit
}
if (state == (138 << 0))
{
    if thrown
        savedthrown = 1
    if (grounded && vsp > 0 && savedthrown)
    {
        stunned = 1
        idle_timer = 1
    }
}
else
    savedthrown = 0
if (state == (138 << 0) && stunned > 100 && birdcreated == 0)
{
    birdcreated = 1
    with (instance_create(x, y, obj_enemybird))
        ID = other.id
}
var _inv = ((state == (138 << 0) && savedthrown == thrown && (!savedthrown)) || ((!obj_player1.ispeppino) && state == (230 << 0) && substate == (136 << 0)))
if (_inv && elitehit > 1)
    invincible = 0
else
    invincible = 1
if (((!invincible) || (_inv && elitehit == 1)) && (!flash) && alarm[5] < 0)
    alarm[5] = 0.15 * room_speed
else if (invincible && (state != (138 << 0) || (savedthrown != thrown && savedthrown) || elitehit > 1) && (state != (230 << 0) || substate != (136 << 0)))
    flash = 0
if (state == (230 << 0) && substate != (8 << 0) && alarm[4] < 0)
    alarm[4] = 6
if (state != (138 << 0))
    birdcreated = 0
if (flash == 1 && alarm[2] <= 0)
    alarm[2] = 0.15 * room_speed
depth = 0
if (state != (138 << 0))
    thrown = 0
if (boundbox == 0)
{
    with (instance_create(x, y, obj_baddiecollisionbox))
    {
        sprite_index = other.sprite_index
        mask_index = other.sprite_index
        baddieID = other.id
        other.boundbox = 1
    }
}
mask_index = spr_pizzaface
scr_pizzaface_update_sounds()

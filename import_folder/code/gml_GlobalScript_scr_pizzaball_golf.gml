function scr_pizzaball_golf()
{
    sprite_index = global.mod_graceball ? spr_pizzaball_stun_grace : spr_pizzaball_stun
    image_speed = 0.35
    vsp = 0
    hsp = 0
    var _i = 9
    
    if (!player.ispeppino)
        _i = 7
    
    if (player.key_up || shootup)
        arrow = 1
    else
        arrow = 0
    
    x = player.x + (23 * player.xscale)
    y = (player.y + 23) - 23
    
    if (player.sprite_index == player.spr_golfswing && floor(player.image_index) == _i)
    {
        x = player.x
        y = player.y
        global.golfhit++
        notification_push(notifications.pizzaball_shot, [player.object_index])
        GamepadSetVibration(0, 0.8, 0.8, 0.65)
        fmod_event_one_shot_3d("event:/sfx/misc/golfpunch", x, y)
        
        if (player.key_up || shootup)
            scr_pizzaball_go_to_thrown(player.xscale * 15, -16, 0)
        else if (player.key_down)
            scr_pizzaball_go_to_thrown(player.xscale * 18, 5, 0)
        else
            scr_pizzaball_go_to_thrown(player.xscale * 17, -7, 0)
        
        if (scr_solid(x, y))
        {
            x = player.x
            y = player.y
            
            while (scr_solid(x, y))
                x += player.xscale
        }
        
        with (instance_create(player.x + (50 * player.xscale), player.y, obj_bangeffect))
            depth = -11
    }
}

enum notifications
{
    bodyslam_start,
    bodyslam_end,
    generic_killed,
    room_enemiesdead,
    enemy_parried,
    level_finished,
    mortcube_destroyed,
    hurt,
    fell_into_pit,
    beer_knocked,
    touched_timedgate,
    flush_done,
    baddie_killed_projectile,
    treasureguy_uncovered,
    special_destroyable_destroyed,
    custom_destructibles_destroyed,
    pizzaball_shot,
    pizzaball_kill,
    pizzaball_goal,
    brickball_start,
    john_destroyed,
    brickball_kill,
    pigcitizen_taunt,
    pizzaboy_killed,
    touched_mrpinch,
    priest_touched,
    secret_entered,
    secret_exited,
    iceblock_bird_freed,
    monster_killed,
    monster_activated,
    jumpscared,
    knightpep_bumped,
    cheeseblock_destroyed,
    rat_destroyed_with_baddie,
    rattumble_destroyed,
    rat_destroyed,
    touched_lava,
    touched_cow,
    touched_cow_once,
    touched_gravesurf_once,
    touched_ghostfollow,
    ghost_end,
    superjump_end,
    shotgun_shot,
    shotgun_shot_end,
    destroyable_destroyed,
    bazooka_explosion,
    wartimer_finished,
    totem_reactivated,
    boss_defeated,
    combo_end,
    achievement_unlocked,
    crouched_in_poo,
    game_beaten,
    taunted,
    john_resurrected,
    knight_obtained,
    mooney_unlocked,
    unknown59,
    pumpkin_gotten,
    pumpkindoor_entered,
    trickytreat_failed,
    trickytreat_door_entered,
    tornadoattack_end,
    gate_taunted,
    noisebomb_wasted,
    got_endingrank,
    breakdance_start,
    touched_banana,
    level_finished_pizzaface,
    player_antigrav,
    ptg_seen,
    touched_granny
}

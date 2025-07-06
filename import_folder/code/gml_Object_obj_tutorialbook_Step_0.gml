if (global.panic && !donepanic)
{
    donepanic = 1
    text = lang_get_value("getout")
    event_perform(ev_other, ev_room_start)
}

text_xscale = (obj_screensizer.actual_width - 64) / sprite_get_width(spr_tutorialbubble)
wave_timer += 20

if (text_xscale != text_oldxscale)
    event_perform(ev_other, ev_room_start)

if (showgranny)
{
    if (voicecooldown > 1)
        voicecooldown--
    else if (!place_meeting(x, y, obj_player))
        voicecooldown = 0
    
    if (place_meeting(x, y, obj_player))
    {
        sprite_index = (global.mod_grannyhuman == 1) ? spr_tutorialgranny_talk_human : spr_tutorialgranny_talk
        
        if (voicecooldown == 0)
        {
            fmod_event_one_shot_3d("event:/sfx/voice/pizzagranny", x, y)
            voicecooldown = 100
        }
    }
    else
    {
        sprite_index = (global.mod_grannyhuman == 1) ? spr_tutorialgranny_sleep_human : spr_tutorialgranny_sleep
    }
}

var _hide = 0

with (obj_grannypizzasign)
{
    if (text_state != states.titlescreen)
        _hide = 1
}

if (instance_exists(obj_mrsticknotification))
    _hide = 1

switch (text_state)
{
    case states.titlescreen:
        repeat (_hide + 1)
            text_y = Approach(text_y, -(text_sprite_height * text_yscale), 5)
        
        if (obj_player1.state != states.backtohub && place_meeting(x, y, obj_player) && !_hide)
        {
            text_state = states.fall
            text_vsp = 0
            
            if (object_index == obj_tutorialbook && ds_list_find_index(global.saveroom, id) == -1)
            {
                ds_list_add(global.saveroom, id)
                notification_push(notifications.touched_granny, [lang_name])
            }
        }
        
        break
    
    case states.fall:
        text_y += text_vsp
        
        if (text_vsp < 20)
            text_vsp += 0.5
        
        if (text_y > text_ystart)
            text_state = states.normal
        
        break
    
    case states.normal:
        text_y = Approach(text_y, text_ystart, 2)
        
        if (!place_meeting(x, y, obj_player) || _hide)
            text_state = states.titlescreen
        
        break
}

text_wave_x = Wave(-5, 5, 2, 10, wave_timer)
text_wave_y = Wave(-1, 1, 4, 0, wave_timer)

enum states
{
    normal,
    revolver,
    dynamite,
    boots,
    grabbed,
    tumble,
    finishingblow,
    ejected,
    transitioncutscene,
    fireass,
    firemouth,
    mort,
    mortjump,
    mortattack,
    morthook,
    hook,
    ghost,
    ghostpossess,
    titlescreen,
    hookshot,
    tacklecharge,
    cheeseball,
    cheeseballclimbwall,
    slap,
    cheesepep,
    cheesepepstick,
    cheesepepjump,
    cheesepepfling,
    cheesepeplaunch,
    cheesepepstickside,
    cheesepepstickup,
    rideweenie,
    motorcycle,
    boxxedpep,
    boxxedpepspin,
    boxxedpepjump,
    pistolaim,
    climbwall,
    knightpepslopes,
    portal,
    secondjump,
    chainsawbump,
    handstandjump,
    lungeattack,
    lungegrab,
    dashtumble,
    gottreasure,
    knightpep,
    knightpepattack,
    knightpepbump,
    meteorpep,
    bombpep,
    bombgrab,
    bombpepside,
    bombpepup,
    grabbing,
    chainsawpogo,
    shotgunjump,
    pogo,
    stunned,
    highjump,
    chainsaw,
    facestomp,
    unknown63,
    timesup,
    machroll,
    shotgun,
    shotguncrouch,
    shotguncrouchjump,
    shotgunshoot,
    shotgundash,
    shotgunfreefall,
    pistol,
    machfreefall,
    throwing,
    slam,
    superslam,
    skateboard,
    grind,
    grab,
    punch,
    backkick,
    uppunch,
    shoulder,
    backbreaker,
    graffiti,
    bossdefeat,
    pizzathrow,
    bossintro,
    gameover,
    keyget,
    tackle,
    jump,
    ladder,
    slipnslide,
    comingoutdoor,
    smirk,
    Sjump,
    victory,
    Sjumpprep,
    crouch,
    crouchjump,
    crouchslide,
    mach1,
    mach2,
    machslide,
    bump,
    hurt,
    freefall,
    hang,
    unknown110,
    freefallland,
    door,
    barrel,
    barreljump,
    barrelclimbwall,
    barrelslide,
    current,
    boulder,
    taxi,
    runonball,
    mach3,
    freefallprep,
    Sjumpland,
    faceplant,
    rage,
    idle,
    bounce,
    charge,
    pizzagoblinthrow,
    turn,
    unknown131,
    unknown132,
    rolling,
    walk,
    fall,
    land,
    hit,
    stun,
    unknown139,
    unknown140,
    chase,
    arenaspawn,
    arenaend,
    arenaintro,
    arenaround,
    actor,
    parry,
    golf,
    float,
    tube,
    unknown151,
    taxi2,
    shoulderbash,
    pummel,
    staggered,
    thrown,
    supershoulderbash,
    superattackstart,
    superattackcharge,
    superattack,
    shoulderturn,
    fistmatch,
    fistmatchend,
    groundpunchstart,
    slipbanan,
    millionpunch,
    skateboardturn,
    bombthrow,
    bombpogo,
    jetpackstart,
    jetpack,
    jetpackstart2,
    jetpackspin,
    mrstick_shield,
    mrstick_helicopterhat,
    mrstick_panicjump,
    mrstick_smokebombstart,
    mrstick_smokebombcrawl,
    mrstick_springshoes,
    mrstick_cardboard,
    mrstick_cardboardend,
    mrstick_mockery,
    bombdelete,
    rocket,
    rocketslide,
    gotoplayer,
    trickjump,
    dance,
    underground,
    ridecow,
    ratmount,
    ratmountjump,
    ratmountattack,
    ratmountspit,
    ratmountclimbwall,
    ratmounthurt,
    ratmountgroundpound,
    ratmountbounce,
    unknown199,
    ratmountballoon,
    ratmounttumble,
    ratmountgrind,
    ratmounttrickjump,
    ratmountskid,
    ratgrabbed,
    blockstance,
    balloon,
    debugstate,
    trashstart,
    trashjump,
    trashroll,
    stringfling,
    stringjump,
    stringfall,
    noisejetpack,
    spiderweb,
    monsteridle,
    monsterintro,
    monsterwalk,
    monsterchase,
    monsterinvestigate,
    monsterrun,
    flushidle,
    flushflip,
    animatronic,
    moustache,
    mouth,
    eyes,
    nose,
    ram,
    phase2transition,
    look,
    fishing,
    unknown234,
    bombrun,
    npcthrow,
    portraitthrow,
    enguarde,
    sexypicture,
    pullinglevel,
    eat,
    surprisebox,
    spinningrun,
    spin,
    spinningpunch,
    groundpunch,
    bigkick,
    slamhead,
    slamhead2,
    whitenoise,
    expression,
    playersuperattack,
    unknown253,
    jetpackjump,
    unknown255,
    unknown256,
    bee,
    beechase,
    ratmountpunch,
    ratmountcrouch,
    ratmountladder,
    supergrab,
    unknown263,
    attract,
    antigrav,
    secret,
    contemplate,
    mini,
    reloading,
    estampede,
    dropstart,
    drop,
    phase1hurt,
    duel,
    deformed,
    grabdash,
    grabthrow,
    wait,
    flamethrower,
    machinegun,
    bazooka,
    crate,
    noisecrusher,
    droptrap,
    noiseskateboard,
    noiseballooncrash,
    swinging,
    stomp,
    finale,
    backtohub,
    ghostcaught,
    spaceshuttle,
    animation,
    pizzaheadjump,
    fightball,
    secretportal,
    teleporter,
    pizzaheadKO,
    follow,
    unknown300,
    unknown301,
    unknown302,
    unknown303,
    unknown304,
    machcancelstart,
    machcancel
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

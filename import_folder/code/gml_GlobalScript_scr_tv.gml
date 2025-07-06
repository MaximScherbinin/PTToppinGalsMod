function tv_set_idle()
{
    with (obj_tv)
    {
        state = states.normal
        sprite_index = spr_tv_idle
    }
}

function tv_reset()
{
    with (obj_tv)
    {
        state = states.normal
        sprite_index = spr_tv_idle
        ds_list_clear(tvprompts_list)
    }
}

function tv_create_prompt(arg0, arg1, arg2, arg3)
{
    return [arg0, arg1, arg2, arg3];
}

function tv_push_prompt(arg0, arg1, arg2, arg3)
{
    with (obj_tv)
    {
        var b = [arg0, arg1, arg2, arg3]
        var play = false
        
        switch (arg1)
        {
            case UnknownEnum.Value_0:
                play = true
                ds_list_insert(tvprompts_list, 0, b)
                break
            
            case UnknownEnum.Value_1:
                var placed = false
                
                for (var i = 0; i < ds_list_size(tvprompts_list); i++)
                {
                    var b2 = ds_list_find_value(tvprompts_list, i)
                    
                    if (b2[1] == UnknownEnum.Value_2)
                    {
                        if (i == 0)
                            play = true
                        
                        ds_list_insert(tvprompts_list, i, b)
                        placed = true
                        break
                    }
                }
                
                if (!placed)
                    ds_list_add(tvprompts_list, b)
                
                break
            
            case UnknownEnum.Value_2:
                ds_list_add(tvprompts_list, b)
                break
        }
        
        if (play)
            state = states.normal
    }
}

function tv_push_prompt_array(arg0)
{
    for (var i = 0; i < array_length(arg0); i++)
    {
        with (obj_tv)
        {
            var b = arg0[i]
            tv_push_prompt(b[0], b[1], b[2], b[3])
        }
    }
}

function tv_push_prompt_once(arg0, arg1)
{
    with (obj_tv)
    {
        if (special_prompts == -4)
            return false;
        
        var b = ds_map_find_value(special_prompts, arg1)
        
        if (is_undefined(b))
            return false;
        
        if (b != 1)
        {
            tv_push_prompt(arg0[0], arg0[1], arg0[2], arg0[3])
            ds_map_set(special_prompts, arg1, 1)
            ini_open_from_string(obj_savesystem.ini_str)
            ini_write_real("Prompts", arg1, 1)
            obj_savesystem.ini_str = ini_close()
            return true;
        }
        
        return false;
    }
}

function tv_default_condition()
{
    return place_meeting(x, y, obj_player);
}

function tv_get_palette()
{
    if (!instance_exists(obj_player1))
        exit
    
    var _info = obj_player1.ispeppino ? get_pep_palette_info() : get_noise_palette_info()
    spr_palette = _info.spr_palette
    
    if (obj_player1.isgustavo && obj_player1.ispeppino)
        spr_palette = spr_ratmountpalette
    
    paletteselect = _info.paletteselect
    patterntexture = _info.patterntexture
}

function tv_do_expression(arg0, arg1 = false, arg2 = false)
{
    with (obj_tv)
    {
        if (expressionsprite != arg0 && bubblespr == -4)
        {
            state = states.whitenoise
            expressionsprite = arg0
            
            switch (expressionsprite)
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
                    
                    if (obj_player.isgustavo)
                    {
                        expressionsprite = spr_tv_happyG
                        
                        if (irandom(100) <= 50)
                            fmod_event_one_shot_3d("event:/sfx/voice/brickok", obj_player1.x, obj_player1.y)
                    }
                    
                    if (irandom(100) <= 50)
                        scr_fmod_soundeffect(obj_player1.snd_voiceok, obj_player1.x, obj_player1.y)
                    
                    break
            }
            
            if (!arg2 && instance_exists(obj_player1) && !obj_player1.ispeppino)
            {
                var n = asset_get_index(sprite_get_name(arg0) + "N")
                
                if (n > -1)
                    expressionsprite = n
            }
            
            if (arg1)
                reset_palette = true
            else
                reset_palette = false
        }
    }
}

function scr_tv_get_transfo_sprite()
{
    var _state = obj_player1.state
    
    if (_state == states.backbreaker || _state == states.chainsaw)
        _state = obj_player1.tauntstoredstate
    
    var _spr = -4
    
    if (instance_exists(obj_bucketfollower))
        _spr = spr_tv_bucket
    
    switch (_state)
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
            else if (obj_player1.shotgunAnim)
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
                if (shotgunAnim)
                    _spr = spr_tv_shotgun
                else if (global.mort)
                    _spr = spr_tv_mort
            }
            
            break
        
        case states.freefallprep:
        case states.freefall:
        case states.freefallland:
            if (obj_player1.shotgunAnim)
                _spr = spr_tv_shotgun
            
            break
        
        case states.pistol:
            if (global.mort)
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
            _spr = global.mod_graceball ? spr_tv_golf_grace : spr_tv_golf
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
            if (obj_player1.skateboarding)
                _spr = spr_tv_clown
            else if (obj_player1.shotgunAnim)
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

enum UnknownEnum
{
    Value_0,
    Value_1,
    Value_2,
    Value_5 = 5,
    Value_9 = 9,
    Value_10,
    Value_11,
    Value_12,
    Value_13,
    Value_14,
    Value_16 = 16,
    Value_17,
    Value_21 = 21,
    Value_24 = 24,
    Value_25,
    Value_26,
    Value_29 = 29,
    Value_30,
    Value_31,
    Value_33 = 33,
    Value_34,
    Value_35,
    Value_37 = 37,
    Value_38,
    Value_42 = 42,
    Value_47 = 47,
    Value_48,
    Value_49,
    Value_51 = 51,
    Value_52,
    Value_57 = 57,
    Value_59 = 59,
    Value_61 = 61,
    Value_65 = 65,
    Value_66,
    Value_67,
    Value_68,
    Value_69,
    Value_70,
    Value_71,
    Value_72,
    Value_78 = 78,
    Value_84 = 84,
    Value_92 = 92,
    Value_93,
    Value_100 = 100,
    Value_104 = 104,
    Value_105,
    Value_106,
    Value_108 = 108,
    Value_111 = 111,
    Value_113 = 113,
    Value_114,
    Value_115,
    Value_116,
    Value_121 = 121,
    Value_122,
    Value_146 = 146,
    Value_148 = 148,
    Value_184 = 184,
    Value_185
}

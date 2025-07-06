switch (state)
{
    case states.idle:
        if (start && distance_to_object(obj_player) <= 150)
        {
            state = states.actor
            substate = states.idle
            cutscenebuffer = 120
            
            with (obj_player)
            {
                state = states.actor
                sprite_index = spr_idle
                movespeed = 0
                image_speed = 0.35
                hsp = 0
                vsp = 0
                
                if (!grounded)
                    create_particle(x, y, particletypes.genericpoofeffect)
            }
        }
        
        break
    
    case states.actor:
        var pizzaface2 = (global.mod_pizzagal == 1) ? spr_pizzafaceshower2_gal : spr_pizzafaceshower2
        var pizzaface4 = (global.mod_pizzagal == 1) ? spr_pizzafaceshower4_gal : spr_pizzafaceshower4
        
        switch (substate)
        {
            case states.idle:
                if (cutscenebuffer > 0)
                {
                    cutscenebuffer--
                }
                else
                {
                    fmod_event_instance_set_parameter(snd, "state", 1, true)
                    substate = states.normal
                    cutscenebuffer = 100
                    sprite_index = spr_pizzafaceshower3
                }
                
                break
            
            case states.normal:
                if (cutscenebuffer > 0)
                {
                    cutscenebuffer--
                }
                else
                {
                    fmod_event_instance_set_parameter(snd, "state", 2, true)
                    substate = states.transitioncutscene
                    cutscenebuffer = 100
                    sprite_index = pizzaface2
                }
                
                break
            
            case states.transitioncutscene:
                if (cutscenebuffer > 0)
                {
                    cutscenebuffer--
                }
                else if (sprite_index == pizzaface2)
                {
                    fmod_event_instance_set_parameter(snd, "state", 3, true)
                    cutscenebuffer = 70
                    sprite_index = spr_pizzafaceshower3
                }
                else
                {
                    fmod_event_instance_set_parameter(snd, "state", 4, true)
                    instance_create(x, y, obj_pizzaface_showerprop)
                    x += 13
                    y += 16
                    sprite_index = pizzaface4
                    substate = states.jump
                    movespeed = 15
                    vsp = -4
                    depth = 5
                }
                
                break
            
            case states.jump:
                movespeed = Approach(movespeed, 0, 0.2)
                vsp = Approach(vsp, -15, 0.1)
                x += movespeed
                y += vsp
                
                if (!bbox_in_camera(view_camera[0], 50))
                {
                    substate = states.gameover
                    
                    with (obj_player)
                    {
                        state = states.normal
                        landAnim = false
                    }
                }
                
                break
            
            case states.gameover:
                y -= 20
                
                if (y < -200)
                {
                    ini_open_from_string(obj_savesystem.ini_str)
                    ini_write_real("Game", "shower", true)
                    obj_savesystem.ini_str = ini_close()
                    instance_destroy()
                }
                
                break
        }
        
        break
}

fmod_event_instance_set_3d_attributes(snd, x, y)

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

enum particletypes
{
    none,
    cloudeffect,
    crazyrunothereffect,
    highjumpcloud1,
    highjumpcloud2,
    jumpdust,
    balloonpop,
    shotgunimpact,
    impact,
    genericpoofeffect,
    keyparticles,
    teleporteffect,
    landcloud,
    ratmountballooncloud,
    groundpoundeffect,
    noisegrounddasheffect,
    last
}

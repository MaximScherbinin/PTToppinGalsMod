global.noisejetpack = 0

if (floor(image_index) == (image_number - 1))
{
    if (sprite_index == spr_rankNPendstart)
    {
        image_index = image_number - 3
    }
    else
    {
        if (sprite_index == spr_rankNPend && image_speed != 0)
        {
            with (obj_camera)
            {
                shake_mag = 2
                shake_mag_acc = 3 / room_speed
            }
            
            fmod_event_one_shot_3d("event:/sfx/pep/groundpound", x, room_height)
        }
        
        image_speed = 0
    }
}

if (sprite_index != spr_rankNPend && sprite_index != spr_rankNPendstart)
{
    if (global.collect >= global.collectN)
    {
        if (obj_player1.character == "P" && obj_player1.ispeppino)
        {
            if (global.rank == "s")
                sprite_index = spr_rankS
            
            if (global.rank == "a")
                sprite_index = spr_rankA
            
            if (global.rank == "b")
                sprite_index = spr_rankB
            
            if (global.rank == "c")
                sprite_index = spr_rankC
            
            if (global.rank == "d")
                sprite_index = spr_rankD
            
            if (global.rank == "p")
                sprite_index = spr_rankP
        }
        else
        {
            if (global.rank == "s")
                sprite_index = spr_rankNS
            
            if (global.rank == "a")
                sprite_index = spr_rankNA
            
            if (global.rank == "b")
                sprite_index = spr_rankNB
            
            if (global.rank == "c")
                sprite_index = spr_rankNC
            
            if (global.rank == "d")
                sprite_index = spr_rankND
            
            if (global.rank == "p")
                sprite_index = spr_rankNP
        }
    }
    
    if (global.collectN > global.collect)
    {
        if (obj_player2.character == "P" && obj_player1.ispeppino)
        {
            if (global.rank == "s")
                sprite_index = spr_rankS
            
            if (global.rank == "a")
                sprite_index = spr_rankA
            
            if (global.rank == "b")
                sprite_index = spr_rankB
            
            if (global.rank == "c")
                sprite_index = spr_rankC
            
            if (global.rank == "d")
                sprite_index = spr_rankD
            
            if (global.rank == "p")
                sprite_index = spr_rankP
        }
        else
        {
            if (global.rank == "s")
                sprite_index = spr_rankNS
            
            if (global.rank == "a")
                sprite_index = spr_rankNA
            
            if (global.rank == "b")
                sprite_index = spr_rankNB
            
            if (global.rank == "c")
                sprite_index = spr_rankNC
            
            if (global.rank == "d")
                sprite_index = spr_rankND
            
            if (global.rank == "p")
                sprite_index = spr_rankNP
        }
    }
}

if (brown)
{
    brownfade = Approach(brownfade, 1, 0.07)
    
    if (brownfade == 1 && sprite_index == spr_rankNP)
    {
        sprite_index = spr_rankNPendstart
        image_index = 0
        image_speed = 1
        alarm[4] = 60
    }
    
    switch (toppin_state)
    {
        case states.jump:
            if (brownfade < 1)
                break
            
            var spd = 20
            var yy = obj_screensizer.actual_height - 133
            toppin_y[toppin_index] -= spd
            toppin_yscale[toppin_index] = 1.2
            
            if (toppin_y[toppin_index] <= yy)
            {
                if (toppin[toppin_index] == 1)
                {
                    createmoney[toppin_index] = true
                    
                    if (toppinvisible)
                        fmod_event_one_shot_3d("event:/sfx/misc/kashing", room_width / 2, room_height / 2)
                }
                
                if (toppinvisible)
                    fmod_event_one_shot_3d("event:/sfx/misc/toppingot", room_width / 2, room_height / 2)
                
                toppin_y[toppin_index] = yy
                toppin_state = states.transitioncutscene
                brown = true
            }
            
            break
        
        case states.transitioncutscene:
            toppin_yscale[toppin_index] = Approach(toppin_yscale[toppin_index], 1, 0.1)
            
            if (toppin_yscale[toppin_index] == 1)
            {
                toppin_index++
                
                if (toppin_index >= array_length(toppin))
                {
                    toppin_state = states.normal
                    alarm[3] = 40
                }
                else
                {
                    toppin_state = states.jump
                }
            }
            
            break
    }
}

if (instance_exists(obj_treasureviewer))
    visible = 0

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

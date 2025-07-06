visible = (room == rank_room || room == timesuproom) ? 0 : playerid.visible

if (obj_player.state == states.pizzathrow)
    visible = 0

playerid = obj_player1.spotlight ? obj_player1 : obj_player2

if (state != states.backbreaker)
{
    if (object_index != obj_pizzakinpineapple || (sprite_index != spr_monsterpineapple_smile && sprite_index != spr_monsterpineapple_pose1 && sprite_index != spr_monsterpineapple_pose2 && sprite_index != spr_monsterpineapple_pose3))
    {
        if (sprite_index == spr_intro && floor(image_index) == (image_number - 1))
            sprite_index = spr_idle
        
        if (sprite_index != spr_intro)
        {
            image_alpha = playerid.image_alpha
            sprite_index = (xprev != x) ? spr_run : spr_idle
            depth = -6
        }
        
        if (global.panic && sprite_index == spr_idle && !instance_exists(obj_ghostcollectibles))
            sprite_index = spr_panic
    }
    else if (object_index == obj_pizzakinpineapple)
    {
        if (image_index > (image_number - 1))
        {
            image_index = 0
            sprite_index = spr_toppinpineapple
        }
    }
    
    if (obj_player1.state == states.backbreaker)
    {
        if (object_index == obj_pizzakincheese && random(100) <= 2)
        {
            instance_create(x, y, obj_tinytaunt)
            sprite_index = spr_toppincheese_special
            image_index = 0
            state = states.backbreaker
            lock = 1
        }
        else if (object_index == obj_pizzakinpineapple && random(100) <= 2)
        {
            instance_create(x, y, obj_tinytaunt)
            sprite_index = spr_toppinpineapple_special
            image_index = 0
            state = states.backbreaker
            lock = 1
        }
        else if (object_index == obj_pizzakinshroom && random(100) <= 2)
        {
            instance_create(x, y, obj_tinytaunt)
            sprite_index = spr_toppinshroom_special
            image_index = 0
            state = states.backbreaker
            lock = 1
            image_speed = 0.35
        }
        else
        {
            instance_create(x, y, obj_tinytaunt)
            sprite_index = spr_taunt
            image_index = irandom(sprite_get_number(spr_taunt) - 1)
            state = states.backbreaker
            lock = 1
        }
    }
}
else
{
    hsp = 0
    vsp = 0
    
    if (sprite_index != spr_intro)
    {
        var s = obj_player1.sprite_index
        
        if (s == obj_player1.spr_supertaunt1 || s == obj_player1.spr_supertaunt2 || s == obj_player1.spr_supertaunt3 || s == obj_player1.spr_supertaunt4 || s == 2685)
        {
            sprite_index = spr_intro
            image_index = 0
        }
    }
    
    if (obj_player1.state != states.backbreaker || (sprite_index == spr_intro && floor(image_index) == (image_number - 1)))
    {
        instance_destroy(obj_tinytaunt)
        interp = 0
        sprite_index = spr_idle
        lock = 0
        state = states.normal
    }
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

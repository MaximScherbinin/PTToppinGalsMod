if (global.gerome || image_index != 0)
{
    if (!uparrow)
    {
        uparrow = 1
        uparrowID = scr_create_uparrowhitbox()
    }
}
else if (uparrow)
{
    uparrow = 0
    instance_destroy(uparrowID)
}

if (!global.horse && (obj_player1.state == states.normal || obj_player1.state == states.mach1 || obj_player1.state == states.pogo || obj_player1.state == states.mach2 || obj_player1.state == states.mach3 || obj_player1.state == states.Sjumpprep) && obj_player1.key_up && obj_player1.grounded && (global.gerome == 1 || image_index == 1) && place_meeting(x, y, obj_player1))
{
    ds_list_add(global.saveroom, id)
    fmod_event_one_shot_3d("event:/sfx/misc/keyunlock", x, y)
    fmod_event_one_shot("event:/sfx/misc/cheers")
    
    with (obj_player)
    {
        targetRoom = other.targetRoom
        targetDoor = other.targetDoor
    }
    
    if (global.gerome)
    {
        obj_geromefollow.visible = 0
        obj_geromefollow.do_end = 1
        
        with (instance_create(obj_player1.x - 30, obj_player1.y, obj_geromeanim))
        {
            sprite_index = global.mod_femgerome ? spr_femgerome_opendoor : spr_gerome_opendoor
            image_index = 0
            image_speed = 0.35
        }
        
        obj_player1.state = states.victory
        obj_player1.image_index = 0
        
        if (instance_exists(obj_player2) && global.coop == 1)
        {
            obj_player2.x = obj_player1.x
            obj_player2.y = obj_player1.y
            obj_player2.state = states.victory
            obj_player2.image_index = 0
        }
        
        global.gerome = 0
    }
    
    image_index = 1
}

if (place_meeting(x, y, obj_player1) && floor(obj_player1.image_index) == (obj_player1.image_number - 1) && (obj_player1.state == states.victory || obj_player1.state == states.door))
{
    with (obj_player1)
    {
        obj_player1.targetDoor = other.targetDoor
        obj_player1.targetRoom = other.targetRoom
        
        if (instance_exists(obj_player2) && global.coop == 1)
        {
            obj_player2.targetDoor = other.targetDoor
            obj_player2.targetRoom = other.targetRoom
        }
        
        if (!instance_exists(obj_fadeout))
            instance_create(x, y, obj_fadeout)
    }
}

if (place_meeting(x, y, obj_doorA))
    targetDoor = "A"

if (place_meeting(x, y, obj_doorB))
    targetDoor = "B"

if (place_meeting(x, y, obj_doorC))
    targetDoor = "C"

if (place_meeting(x, y, obj_doorD))
    targetDoor = "D"

if (place_meeting(x, y, obj_doorE))
    targetDoor = "E"

if (place_meeting(x, y, obj_doorF))
    targetDoor = "F"

if (place_meeting(x, y, obj_doorG))
    targetDoor = "G"

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

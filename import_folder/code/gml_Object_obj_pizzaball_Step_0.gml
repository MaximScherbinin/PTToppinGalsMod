if (room == rm_editor)
    exit

if (state == states.walk && grounded && vsp > 0 && (obj_player1.state == states.freefallland || (obj_player1.state == states.ratmountbounce && obj_player1.sprite_index == spr_playerN_noisecrusherland)) && bbox_in_camera(view_camera[0], 32))
    scr_pizzaball_go_to_thrown(0, -10)

arrowindex += 0.35

switch (state)
{
    case states.idle:
        scr_enemy_idle()
        break
    
    case states.turn:
        scr_enemy_turn()
        break
    
    case states.walk:
        scr_enemy_walk()
        break
    
    case states.land:
        scr_enemy_land()
        break
    
    case states.hit:
        scr_pizzaball_hit()
        break
    
    case states.golf:
        scr_pizzaball_golf()
        break
    
    case states.thrown:
        scr_pizzaball_thrown()
        break
    
    case states.stun:
        scr_enemy_stun()
        
        if (stunned > 0)
            stunned -= 1
        
        break
    
    case states.pizzagoblinthrow:
        scr_pizzagoblin_throw()
        break
    
    case states.grabbed:
        scr_pizzaball_grabbed()
        break
    
    case states.pummel:
        scr_enemy_pummel()
        break
    
    case states.staggered:
        scr_enemy_staggered()
        break
    
    case states.rage:
        scr_enemy_rage()
        break
    
    case states.ghostpossess:
        scr_enemy_ghostpossess()
        break
}

if (state != states.golf)
{
    shootup = 0
    arrow = 0
}

if (state == states.thrown)
{
    if (blur_effect > 0)
    {
        blur_effect--
    }
    else
    {
        blur_effect = 2
        
        with (create_blur_afterimage(x, y, sprite_index, image_index - 1, xscale))
            playerid = other.id
    }
}

if ((state == states.walk || state == states.idle) && sit)
{
    hsp = 0
    sprite_index = global.mod_graceball ? spr_pizzaball_idle1_grace : spr_pizzaball_idle1
}

if (state != states.walk)
    sit = 0

if (state == states.stun && stunned > 100 && birdcreated == 0)
{
    birdcreated = 1
    
    with (instance_create(x, y, obj_enemybird))
        ID = other.id
}

if (state == states.thrown && !instance_exists(pointerID))
{
    pointerID = instance_create(x, y, obj_objecticontracker)
    pointerID.sprite_index = global.mod_graceball ? spr_icon_pizzaball_grace : spr_icon_pizzaball
    pointerID.objectID = id
}

if (state != states.stun)
    birdcreated = 0

if (flash == 1 && alarm[2] <= 0)
    alarm[2] = 0.15 * room_speed

if (bigcheeseID != -4)
{
    if (!instance_exists(bigcheeseID) || bigcheeseID.state != states.throwing || bigcheeseID.shot)
    {
        if (instance_exists(bigcheeseID) && bigcheeseID.object_index == obj_golfburger && sprite_index == stunfallspr)
            sprite_index = walkspr
        
        bigcheeseID = -4
    }
    else
    {
        invincible = 1
    }
}
else
{
    invincible = 0
}

if (hitbuffer > 0)
{
    invincible = 1
    hitbuffer--
}

if (state != states.grabbed)
    depth = 0

if (state != states.stun)
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

if (state == states.thrown)
{
    with (instance_place(x + xscale, y, obj_destructibles))
        instance_destroy()
    
    with (instance_place(x + hsp + xscale, y, obj_destructibles))
        instance_destroy()
    
    with (instance_place(x, y + vsp + 1, obj_destructibles))
        instance_destroy()
    
    with (instance_place(x, (y + vsp) - 1, obj_destructibles))
        instance_destroy()
    
    with (instance_place(x, y + 1, obj_destructibles))
        instance_destroy()
    
    with (instance_place(x, y - 1, obj_destructibles))
        instance_destroy()
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

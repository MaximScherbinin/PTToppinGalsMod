targetplayer = obj_player1.id
wastedhits = 8 - elitehit
destroyable = 0

switch (state)
{
    case states.arenaintro:
        scr_pizzaface_arenaintro()
        break
    
    case states.walk:
        scr_pizzaface_normal()
        break
    
    case states.ram:
        scr_pizzaface_ram()
        break
    
    case states.transitioncutscene:
        scr_pizzaface_transitioncutscene()
        break
    
    case states.phase1hurt:
        lasthit = 1
        scr_boss_phase1hurt()
        sprite_index = global.mod_spr_pizzaface_hurt
        image_speed = 0.35
        break
    
    case states.hit:
        scr_enemy_hit()
        break
    
    case states.stun:
        scr_enemy_stun()
        break
    
    case states.grabbed:
        scr_boss_grabbed()
        break
    
    case states.pummel:
        scr_enemy_pummel()
        break
    
    case states.staggered:
        scr_enemy_staggered()
        break
}

if (superslambuffer > 0)
    superslambuffer--

if (state != states.walk)
    on_y = 1

if (prevhp != elitehit)
{
    if (elitehit < prevhp)
    {
        baddie_range++
        cooldown = 0
        attackbuffer = 0
        touchedground = 0
        hsp += (-image_xscale * 5)
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
            state = states.transitioncutscene
            substate = states.animation
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
                state = states.actor
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

if (state == states.stun)
{
    if (thrown)
        savedthrown = 1
    
    if (grounded && vsp > 0 && savedthrown)
    {
        stunned = 1
        idle_timer = 1
    }
}
else
{
    savedthrown = 0
}

if (state == states.stun && stunned > 100 && birdcreated == 0)
{
    birdcreated = 1
    
    with (instance_create(x, y, obj_enemybird))
        ID = other.id
}

var _inv = (state == states.stun && savedthrown == thrown && !savedthrown) || (!obj_player1.ispeppino && state == states.ram && substate == states.land)

if (_inv && elitehit > 1)
    invincible = 0
else
    invincible = 1

if ((!invincible || (_inv && elitehit == 1)) && !flash && alarm[5] < 0)
    alarm[5] = 0.15 * room_speed
else if (invincible && (state != states.stun || (savedthrown != thrown && savedthrown) || elitehit > 1) && (state != states.ram || substate != states.land))
    flash = 0

if (state == states.ram && substate != states.transitioncutscene && alarm[4] < 0)
    alarm[4] = 6

if (state != states.stun)
    birdcreated = 0

if (flash == 1 && alarm[2] <= 0)
    alarm[2] = 0.15 * room_speed

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

mask_index = spr_pizzaface
scr_pizzaface_update_sounds()

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

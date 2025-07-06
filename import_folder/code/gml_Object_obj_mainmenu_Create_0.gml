currentselect = 0
optionbuffer = 0
visualselect = 0
state = states.titlescreen
image_speed = 0.35
depth = 0
mainmenu_sprite = -1
controls_sprite = -1
angrybuffer = 0
savedsprite = -4
savedindex = 0
deleteselect = 1
exitselect = 1
percvisual = 0
taunt_key = scr_compile_icon_text("[x]")
grab_key = scr_compile_icon_text("[q]")
start_key = scr_compile_icon_text("[p]")
jumpscarecount = 0
quitbuffer = 0
vsp = 0
shownoise = false
showswap = false
charselect = 0
showbuffer_max = 300
john = true
snotty = true
toppingals = true
judgement = "confused"
deletebuffer = 0
obj_player1.player_paletteselect[0] = 1
obj_player1.player_paletteselect[1] = 1
percentage = 0
perstatus_icon = 0
extrauialpha = 0
punch_x = 0
punch_y = 0
key_jump = false
index = 0
bombsnd = fmod_event_create_instance("event:/sfx/ui/bombfuse")
scr_init_input()
pep_game = -4
pep_percvisual = 0
pep_alpha = 1
noise_game = -4
noise_percvisual = 0
noise_alpha = 0
noise_unlocked = false
pep_debris = false
swap_unlocked = false
game_icon_y = 0
game_icon_buffer = 0
game_icon_index = 0
punch_count = 0

unlock_noise = function(arg0)
{
    for (var i = 0; i < 3; i++)
    {
        if (global.game[i].judgement != "none" || global.gameN[i].judgement != "none")
        {
            arg0 = true
            break
        }
    }
    
    if (!arg0)
    {
        ini_open_from_string(obj_savesystem.ini_str_options)
        arg0 = ini_read_real("Game", "beaten", 0) > 0
        
        if (!arg0)
            arg0 = ini_read_real("Game", "noiseunlocked", 0)
        
        ini_close()
    }
    
    if (arg0)
    {
        noise_unlocked = true
        ini_open_from_string(obj_savesystem.ini_str_options)
        
        if (ini_read_real("Game", "noiseunlocked", 0) == 0)
        {
            instance_create(0, 0, obj_noiseunlocked)
            ini_write_real("Game", "noiseunlocked", 1)
            obj_savesystem.ini_str_options = ini_close()
            gamesave_async_save_options()
        }
        else
        {
            ini_close()
        }
    }
}

unlock_swap = function(arg0)
{
    for (var i = 0; i < 3; i++)
    {
        if (global.gameN[i].judgement != "none")
        {
            arg0 = true
            break
        }
    }
    
    if (!arg0)
    {
        ini_open_from_string(obj_savesystem.ini_str_options)
        arg0 = ini_read_real("Game", "swapunlocked", 0)
        ini_close()
    }
    
    if (arg0)
    {
        swap_unlocked = true
        ini_open_from_string(obj_savesystem.ini_str_options)
        
        if (ini_read_real("Game", "swapunlocked", 0) == 0)
        {
            with (instance_create(0, 0, obj_noiseunlocked))
                sprite_index = spr_swapmodeunlocked
            
            ini_write_real("Game", "swapunlocked", 1)
            obj_savesystem.ini_str_options = ini_close()
            gamesave_async_save_options()
        }
        else
        {
            ini_close()
        }
    }
}

unlock_noise(false)
ini_open_from_string(obj_savesystem.ini_str_options)
swap_unlocked = ini_read_real("Game", "swapmode", 0) == 1
ini_close()

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

global.coop = false
global.currentsavefile = 1
var achievement_arr = ["sranks1", "sranks2", "sranks3", "sranks4", "sranks5"]
var data_arr = [get_save_folder() + "/saveData1", get_save_folder() + "/saveData2", get_save_folder() + "/saveData3"]
global.stickreq[0] = 100
global.stickreq[1] = 150
global.stickreq[2] = 200
global.stickreq[3] = 200
global.stickreq[4] = 210
global.levelattempts = 0
global.palette_arr = [false, false, false, false, false]

for (var i = 0; i < array_length(data_arr); i++)
{
    global.game[i] = scr_read_game(data_arr[i] + ".ini")
    global.gameN[i] = scr_read_game(data_arr[i] + "N.ini")
}

global.newtoppin[0] = false
global.newtoppin[1] = false
global.newtoppin[2] = false
global.newtoppin[3] = false
global.newtoppin[4] = false
global.mach_color1 = make_colour_rgb(96, 208, 72)
global.mach_color2 = make_colour_rgb(248, 0, 0)
global.afterimage_color1 = make_colour_rgb(255, 0, 0)
global.afterimage_color2 = make_colour_rgb(0, 255, 0)
global.smallnumber_color1 = make_colour_rgb(255, 255, 255)
global.smallnumber_color2 = make_colour_rgb(248, 0, 0)
scr_tg_vars_init()
global.optimize = 0
global.autotile = true
global.smallnumber_fnt = font_add_sprite_ext(spr_smallnumber, "1234567890-+", true, 0)
global.pigreduction = 0
global.pigtotal = 0
global.levelcomplete = false
global.levelcompletename = -4
global.entrancetreasure = false
global.medievaltreasure = false
global.ruintreasure = false
global.dungeontreasure = false
global.deserttreasure = false
global.graveyardtreasure = false
global.farmtreasure = false
global.spacetreasure = false
global.beachtreasure = false
global.foresttreasure = false
global.pinballtreasure = false
global.golftreasure = false
global.streettreasure = false
global.sewertreasure = false
global.factorytreasure = false
global.freezertreasure = false
global.chateautreasure = false
global.mansiontreasure = false
global.kidspartytreasure = false
global.wartreasure = false
global.entrancecutscene = -4
global.medievalcutscene = -4
global.ruincutscene = -4
global.ruincutscene2 = -4
global.ruincutscene3 = -4
global.dungeoncutscene = -4
global.peppermancutscene1 = -4
global.peppermancutscene2 = -4
global.chieftaincutscene = -4
global.chieftaincutscene2 = -4
global.desertcutscene = -4
global.graveyardcutscene = -4
global.spacecutscene = -4
global.vigilantecutscene1 = -4
global.vigilantecutscene2 = -4
global.vigilantecutscene3 = -4
global.farmcutscene = -4
global.superpinballcutscene = -4
global.pubcutscene = -4
global.pinballcutscene = -4
global.beercutscene = -4
global.exitfeecutscene = -4
global.forestcutscene = -4
global.bottlecutscene = -4
global.papercutscene = -4
global.beachboatcutscene = -4
global.beachcutscene = -4
global.sewercutscene = -4
global.burgercutscene = -4
global.golfcutscene = -4
global.anarchistcutscene1 = -4
global.anarchistcutscene2 = -4
global.factoryblock = -4
global.streetcutscene = -4
global.graffiticutscene = -4
global.factorygraffiti = -4
global.factorycutscene = -4
global.hatcutscene1 = -4
global.hatcutscene2 = -4
global.hatcutscene3 = -4
global.jetpackcutscene = -4
global.noisecutscene1 = -4
global.noisecutscene2 = -4
global.freezercutscene = -4
global.kidspartycutscene = -4
global.gasolinecutscene = -4
global.mansioncutscene = -4
global.chateaucutscene = -4
global.ghostsoldiercutscene = -4
global.mrstickcutscene1 = -4
global.mrstickcutscene2 = -4
global.mrstickcutscene3 = -4
global.chateauswap = -4
global.warcutscene = -4
pal_swap_init_system(12)

with (obj_player1)
    state = states.normal

global.loadeditor = false

if (global.longintro)
{
    global.longintro = false
    room_goto(Longintro)
}
else
{
    room_goto(Mainmenu)
}

instance_destroy(obj_cutscene_handler)

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

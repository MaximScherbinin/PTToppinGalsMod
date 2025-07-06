function scr_pizzaface_init_sounds()
{
    snd_ram = fmod_event_create_instance("event:/sfx/pizzaface/ram")
    snd_haywire = fmod_event_create_instance("event:/sfx/pizzahead/haywire")
    snd_spit = fmod_event_create_instance("event:/sfx/pizzaface/spit")
    snd_wind = fmod_event_create_instance("event:/sfx/misc/windloop")
}

function scr_pizzaface_destroy_sounds()
{
    destroy_sounds([snd_ram, snd_spit, snd_haywire, snd_wind])
}

function scr_pizzaface_update_sounds()
{
    if (state == states.ram && (substate == states.arenaintro || substate == states.ram))
    {
        if (!fmod_event_instance_is_playing(snd_ram))
            fmod_event_instance_play(snd_ram)
        
        fmod_event_instance_set_3d_attributes(snd_ram, x, y)
    }
    else
    {
        fmod_event_instance_stop(snd_ram, true)
    }
    
    if (state == states.transitioncutscene)
    {
        if (!fmod_event_instance_is_playing(snd_haywire))
            fmod_event_instance_play(snd_haywire)
        
        fmod_event_instance_set_3d_attributes(snd_haywire, x, y)
    }
    else
    {
        fmod_event_instance_stop(snd_haywire, true)
    }
    
    if (state == states.arenaintro)
    {
        if (!fmod_event_instance_is_playing(snd_wind))
            fmod_event_instance_play(snd_wind)
    }
    else
    {
        fmod_event_instance_stop(snd_wind, true)
    }
}

function scr_pizzaface_arenaintro()
{
    if (!skipintro)
    {
        image_speed = 0.35
        hsp = 0
        vsp = 0
        x = room_width * 0.75
        
        with (obj_player1)
        {
            state = states.actor
            image_speed = 0.35
            xscale = 1
            hsp = 0
            movespeed = 0
            flash = false
            x = roomstartx
        }
        
        with (obj_player2)
            visible = false
        
        switch (introstate)
        {
            case 0:
                y = ystart
                sprite_index = spr_pizzaface
                
                with (obj_player1)
                {
                    sprite_index = spr_rockethitwall
                    y = room_height
                }
                
                introstate++
                playervsp = -15
                break
            
            case 1:
                with (obj_player1)
                {
                    if (place_meeting(x, y, obj_solid))
                    {
                        vsp = 0
                        hsp = 0
                        y += other.playervsp
                        
                        if (!place_meeting(x, y, obj_solid))
                            vsp = other.playervsp
                    }
                    else if (grounded && vsp > 0)
                    {
                        fmod_event_one_shot_3d("event:/sfx/pep/groundpound", x, y)
                        other.introstate++
                        other.introbuffer = 80
                        sprite_index = spr_slipbanan2
                        image_index = 0
                    }
                }
                
                break
            
            case 2:
                with (obj_player1)
                {
                    if (floor(image_index) == (image_number - 1))
                        image_index = image_number - 1
                }
                
                if (introbuffer > 0)
                {
                    introbuffer--
                }
                else
                {
                    introstate++
                    introbuffer = 80
                    
                    with (obj_player1)
                    {
                        sprite_index = spr_facehurtup
                        image_index = 0
                    }
                }
                
                break
            
            case 3:
                with (obj_player1)
                {
                    if (floor(image_index) == (image_number - 1) && sprite_index == spr_facehurtup)
                        sprite_index = spr_facehurt
                }
                
                if (introbuffer > 0)
                {
                    introbuffer--
                }
                else
                {
                    introstate++
                    introbuffer = 80
                    
                    with (obj_player1)
                    {
                        sprite_index = spr_pepbossintro1
                        
                        if (!ispeppino)
                            sprite_index = spr_noisebossintro1
                        
                        image_index = 0
                    }
                }
                
                break
            
            case 4:
                with (obj_player1)
                {
                    if (floor(image_index) == (image_number - 1))
                        image_index = image_number - 3
                }
                
                if (introbuffer > 0)
                    introbuffer--
                else
                    introstate++
                
                break
            
            case 5:
                with (obj_player1)
                {
                    if (floor(image_index) == (image_number - 1))
                        image_index = image_number - 3
                }
                
                var ty = room_height / 2
                y = Approach(y, ty, 2)
                
                if (y > 0)
                {
                    with (obj_player1)
                    {
                        if (sprite_index != spr_pepbossintro2 && sprite_index != spr_noisebossintro2)
                        {
                            sprite_index = spr_pepbossintro2
                            
                            if (!ispeppino)
                                sprite_index = spr_noisebossintro2
                            
                            image_index = 0
                        }
                    }
                }
                
                if (y == ty)
                {
                    introstate++
                    
                    with (obj_player1)
                    {
                        if (ispeppino)
                            fmod_event_one_shot_3d("event:/sfx/voice/peppinoangryscream", x, y)
                        else
                            fmod_event_one_shot_3d("event:/sfx/voice/woag", x, y)
                        
                        sprite_index = spr_pepbossintro3
                        
                        if (!ispeppino)
                            sprite_index = spr_noisebossintro3
                        
                        image_index = 0
                    }
                    
                    sprite_index = global.mod_spr_pizzaface_intro1
                    image_index = 0
                }
                
                break
            
            case 6:
                var _finish = false
                
                if (floor(image_index) == (image_number - 1) && sprite_index == global.mod_spr_pizzaface_intro1)
                {
                    fmod_event_one_shot("event:/sfx/pizzaface/laugh")
                    sprite_index = global.mod_spr_pizzaface_intro2
                    image_index = 0
                }
                else if (floor(image_index) == (image_number - 1) && sprite_index == global.mod_spr_pizzaface_intro2)
                {
                    sprite_index = global.mod_spr_pizzaface
                }
                
                with (obj_player1)
                {
                    if (floor(image_index) == (image_number - 1))
                    {
                        _finish = true
                        image_index = image_number - 3
                    }
                }
                
                if (sprite_index == global.mod_spr_pizzaface && _finish)
                {
                    state = states.walk
                    
                    with (obj_player1)
                    {
                        state = states.normal
                        sprite_index = spr_idle
                    }
                }
                
                break
        }
    }
    else
    {
        x = room_width * 0.75
        y = (room_height / 2) - 100
        vsp = 0
        scr_boss_genericintro(global.mod_spr_pizzaface)
        
        with (obj_player)
        {
            sprite_index = spr_3hpidle
            xscale = 1
        }
    }
}

function scr_pizzaface_normal()
{
    if (lasthit)
    {
        elitehit = 0
        exit
    }
    
    while (place_meeting(x, y, obj_solid))
        x += ((x > (room_width / 2)) ? -1 : 1)
    
    image_speed = 0.35
    
    if (flickertime <= 0)
    {
        image_xscale = 1
        hsp = floatdir * 5
        vsp = 0
        var ty = room_height * 0.3
        y = Approach(y, ty, 2)
        
        if (y == ty && !on_y)
            on_y = true
        
        if (!on_y)
        {
            if (alarm[8] == -1)
                alarm[8] = 5
        }
        
        if (place_meeting(x + floatdir, y, obj_solid))
            floatdir *= -1
        
        if (sprite_index != global.mod_spr_pizzaface_nosespit1 && sprite_index != global.mod_spr_pizzaface_nosespit2 && sprite_index != global.mod_spr_pizzaface_nosespit3)
        {
            if (!on_y)
            {
                sprite_index = spr_pizzaface_recovering
            }
            else if (sprite_index == spr_pizzaface_recovering)
            {
                sprite_index = global.mod_spr_pizzaface_attackend
                image_index = 0
                state = states.ram
                substate = states.transitioncutscene
                hsp = 0
                exit
            }
            else
            {
                sprite_index = global.mod_spr_pizzaface
            }
            
            if (on_y)
            {
                if (attackbuffer > 0)
                {
                    attackbuffer--
                }
                else
                {
                    attackbuffer = 120 - (wastedhits * 15)
                    
                    if (nosespit)
                    {
                        nosespit = false
                        scr_fmod_soundeffect(snd_spit, x, y)
                        sprite_index = global.mod_spr_pizzaface_nosespit1
                        image_index = 0
                        nosecount = 0 + floor(wastedhits / 3)
                    }
                    else
                    {
                        nosespit = true
                        state = states.ram
                        sprite_index = global.mod_spr_pizzaface_attackstart
                        image_index = 0
                        substate = states.arenaintro
                        ramdir = point_direction(x, y, targetplayer.x + irandom_range(-50, 50), 402)
                        ramhsp = -lengthdir_x(6, ramdir)
                        ramvsp = -lengthdir_y(6, ramdir)
                        
                        if (x != targetplayer.x)
                            image_xscale = sign(targetplayer.x - x)
                        else if (ramhsp != 0)
                            image_xscale = sign(ramhsp)
                    }
                }
            }
        }
        else if (floor(image_index) == (image_number - 1))
        {
            if (sprite_index == global.mod_spr_pizzaface_nosespit1)
            {
                sprite_index = global.mod_spr_pizzaface_nosespit2
                var b = baddie_arr[irandom_range(0, baddie_range - 1)]
                
                with (instance_create(x, y, b[0]))
                {
                    important = true
                    state = states.pizzaheadjump
                    vsp = 10
                }
            }
            else if (sprite_index == global.mod_spr_pizzaface_nosespit2)
            {
                sprite_index = global.mod_spr_pizzaface_nosespit3
            }
            else if (sprite_index == global.mod_spr_pizzaface_nosespit3)
            {
                if (nosecount > 0)
                {
                    scr_fmod_soundeffect(snd_spit, x, y)
                    nosecount--
                    sprite_index = global.mod_spr_pizzaface_nosespit1
                }
                else
                {
                    sprite_index = global.mod_spr_pizzaface
                }
            }
        }
    }
    else
    {
        on_y = false
        sprite_index = global.mod_spr_pizzaface_hurt
        
        if (grounded)
            hsp = Approach(hsp, 0, 0.25)
        
        if (place_meeting(x + hsp, y, obj_solid))
        {
            hsp *= -1
            image_xscale *= -1
        }
        
        if (grounded && vsp > 0 && flickertime > 0)
        {
            hsp = Approach(hsp, 0, 0.5)
            create_particle(x, 401, particletypes.landcloud)
            vsp = -5
            touchedground = true
        }
    }
}

function scr_pizzaface_ram()
{
    switch (substate)
    {
        case states.arenaintro:
            ramhsp = Approach(ramhsp, 0, 0.3)
            ramvsp = Approach(ramvsp, 0, 0.3)
            hsp = ramhsp
            vsp = ramvsp
            
            if (floor(image_index) == (image_number - 1))
            {
                substate = states.ram
                var s = wastedhits
                ramhsp = lengthdir_x(18 + s, ramdir)
                ramvsp = lengthdir_y(18 + s, ramdir)
                sprite_index = global.mod_spr_pizzaface_attack
            }
            
            break
        
        case states.ram:
            hsp = ramhsp
            vsp = ramvsp
            
            if (vsp < -5)
                vsp = 12
            
            if ((vsp > 0 && grounded) || place_meeting(x + sign(hsp), y, obj_solid))
            {
                fmod_event_one_shot_3d("event:/sfx/pep/groundpound", x, y)
                substate = states.land
                landbuffer = 80
                hitX = x
                hitY = y
                sprite_index = global.mod_spr_pizzaface_attackland
                image_index = 0
                
                if (instance_number(obj_baddie) < 6)
                {
                    var b = baddie_arr[irandom_range(0, baddie_range - 1)]
                    
                    with (instance_create(irandom_range(50, room_width - 50), room_height + 30, b[0]))
                    {
                        important = true
                        sprite_index = b[1]
                        state = states.pizzaheadjump
                    }
                }
                
                with (obj_camera)
                {
                    shake_mag = 3
                    shake_mag_acc = 5 / room_speed
                }
            }
            
            break
        
        case states.land:
            hsp = 0
            x = hitX + irandom_range(-1, 1)
            y = hitY + irandom_range(-1, 1)
            
            if (floor(image_index) == (image_number - 1))
            {
                fmod_event_one_shot_3d("event:/sfx/pizzaface/jump", x, y)
                substate = states.jump
                sprite_index = global.mod_spr_pizzaface_attackjump
                image_index = 0
                vsp = -14
                x = hitX
                y = hitY
            }
            
            break
        
        case states.jump:
            if (floor(image_index) == (image_number - 1))
                image_index = image_number - 1
            
            if (vsp > 0)
            {
                substate = states.transitioncutscene
                vsp = 0
                sprite_index = global.mod_spr_pizzaface_attackend
                image_index = 0
            }
            
            break
        
        case states.transitioncutscene:
            vsp = 0
            
            if (floor(image_index) == (image_number - 1))
                state = states.walk
            
            break
    }
}

function scr_pizzaface_transitioncutscene()
{
    image_speed = 0.35
    image_alpha = 1
    alarm[6] = -1
    alarm[8] = -1
    hsp = 0
    vsp = 0
    
    with (obj_player1)
    {
        if (floor(image_index) == (image_number - 1))
        {
            if (sprite_index == spr_pepbossintro2)
                image_index = image_number - 2
            else if (sprite_index == spr_pepbossintro1)
                image_index = image_number - 2
            else if (sprite_index == spr_pepbossintro2)
                image_index = image_number - 3
            else if (sprite_index == spr_noisebossintro1)
                image_index = image_number - 3
            else if (sprite_index == spr_noisebossintro2)
                image_index = image_number - 3
        }
    }
    
    switch (substate)
    {
        case states.animation:
            if (introbuffer > 0)
                introbuffer--
            else
                substate = states.transitioncutscene
            
            with (obj_player1)
            {
                hsp = 0
                vsp = 0
                xscale = 1
                movespeed = 0
                x = roomstartx
                y = 402
                
                if (sprite_index != spr_player_gnomecutscene1 && sprite_index != spr_noisebossintro1)
                {
                    image_index = 0
                    sprite_index = spr_player_gnomecutscene1
                    
                    if (!ispeppino)
                        sprite_index = spr_noisebossintro1
                }
                
                image_speed = 0.35
                image_alpha = 1
                state = states.actor
            }
            
            break
        
        case states.transitioncutscene:
            sprite_index = global.mod_spr_pizzahead_intro1
            var tx = room_width / 2
            var ty = room_height * 0.35
            var _dir = point_direction(x, y, tx, ty)
            x += lengthdir_x(2, _dir)
            y += lengthdir_y(2, _dir)
            
            if (abs(x - tx) <= 10 && abs(y - ty) <= 10)
            {
                with (obj_player1)
                {
                    sprite_index = spr_pepbossintro2
                    
                    if (!ispeppino)
                        sprite_index = spr_noisebossintro2
                    
                    image_index = 0
                }
                
                x = tx
                y = ty
                substate = states.hit
                sprite_index = global.mod_spr_pizzahead_intro2
                image_index = 0
                fmod_event_one_shot_3d("event:/sfx/pizzaface/open", x, y)
            }
            
            break
        
        case states.hit:
            if (floor(image_index) == (image_number - 1))
            {
                fmod_event_one_shot_3d("event:/sfx/misc/explosion", x, y)
                
                with (instance_create(x, y, obj_explosioneffect))
                    sprite_index = spr_bombexplosion
                
                with (instance_create(x, y, obj_pizzafaceboss_p2))
                {
                    vsp = 0
                    hsp = 0
                    state = states.fall
                    substate = states.jump
                    sprite_index = spr_pizzahead_intro3
                    
                    if (x != obj_player1.x)
                        image_xscale = sign(obj_player1.x - x)
                    
                    with (obj_bosscontroller)
                        bossID = other.id
                }
                
                scr_pizzaface_destroy_sounds()
                instance_destroy(id, false)
            }
            
            break
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

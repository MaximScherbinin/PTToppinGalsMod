depth = 100
mask_index = spr_gerome_collected
scr_create_uparrowhitbox()
showtext = 0
alpha = 0
title = "Janice A.K.A. Fem-Gerome (Made by Benny):"
desc = (global.mod_femgerome == 1 ? "Enabled" : "Disabled")
sprite_index = (global.mod_femgerome == 1 ? spr_femgerome_collected : spr_gerome_collected)
image_speed = 0.35
state = -1
sub_state = 0
timebuffer = 0
rat_mouth = -1
rat_stuffed = -1
cursor_spr = spr_mrpinch_hand1
cursor_state = 0
_image_index = 0
rat = 
{
    x: obj_screensizer.actual_width,
    y: obj_screensizer.actual_height,
    sprite_index: sprite_index,
    scale: 2
}

shroom = 
{
    state: (0 << 0),
    x: (obj_screensizer.actual_width * 0.15),
    y: 100,
    spr_idle: spr_toppinshroom,
    spr_panic: spr_toppinshroom_panic,
    spr_pal: spr_shroompalette,
    sprite_index: spr_toppinshroom,
    image_index: 0,
    image_speed: 0.35,
    scale: 1,
    angle: 0
}

cheese = 
{
    state: (0 << 0),
    x: (obj_screensizer.actual_width * 0.3),
    y: 100,
    spr_idle: spr_toppincheese,
    spr_panic: spr_toppincheese_panic,
    spr_pal: spr_cheesepalette,
    sprite_index: spr_toppincheese,
    image_index: 0,
    image_speed: 0.35,
    scale: 1,
    angle: 0
}

tomato = 
{
    state: (0 << 0),
    x: (obj_screensizer.actual_width * 0.45),
    y: 100,
    spr_idle: spr_toppintomato,
    spr_panic: spr_toppintomato_panic,
    spr_pal: spr_tomatopalette,
    sprite_index: spr_toppintomato,
    image_index: 0,
    image_speed: 0.35,
    scale: 1,
    angle: 0
}

sausage = 
{
    state: (0 << 0),
    x: (obj_screensizer.actual_width * 0.6),
    y: 100,
    spr_idle: spr_toppinsausage,
    spr_panic: spr_toppinsausage_panic,
    spr_pal: spr_sausagepalette,
    sprite_index: spr_toppinsausage,
    image_index: 0,
    image_speed: 0.35,
    scale: 1,
    angle: 0
}

pineapple = 
{
    state: (0 << 0),
    x: (obj_screensizer.actual_width * 0.75),
    y: 100,
    spr_idle: spr_toppinpineapple,
    spr_panic: spr_toppinpineapple_panic,
    spr_pal: spr_papplepalette,
    sprite_index: spr_toppinpineapple,
    image_index: 0,
    image_speed: 0.35,
    scale: 1,
    angle: 0
}

toppin_array = [shroom, cheese, tomato, sausage, pineapple]

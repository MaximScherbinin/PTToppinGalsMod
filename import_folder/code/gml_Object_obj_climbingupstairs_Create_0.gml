targetRoom = room
targetDoor = "A"
image_speed = 0.4
depth = 0
state = states.idle
gerome_spr = (global.mod_femgerome == 1 ? spr_femgeromewalkelevator : spr_geromewalkelevator)
gerome_x = obj_screensizer.actual_width + 100
gerome_y = 205
gerome_index = 0
cliff_index = 0
cliff_x = obj_screensizer.actual_width
cliff_y = 256
peppino_index = 0
peppino_x = obj_screensizer.actual_width / 2
peppino_xstart = peppino_x
peppino_y = 426
with (obj_player)
{
    state = states.titlescreen
    x = (-obj_screensizer.actual_width) - 100
    y = (-obj_screensizer.actual_height) - 100
}

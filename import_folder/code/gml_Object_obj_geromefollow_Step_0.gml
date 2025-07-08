if (sprite_index == spr_collected && floor(image_index) == (image_number - 1))
    sprite_index = spr_keyidle
if (room == rank_room || room == timesuproom)
    visible = false
if (obj_player1.spotlight == true)
    playerid = obj_player1
else
    playerid = obj_player2
image_speed = 0.35
depth = -6

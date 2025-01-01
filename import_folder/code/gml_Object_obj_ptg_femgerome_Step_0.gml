var lmb_press = mouse_check_button(mb_left)
var mouse_xx = display_mouse_get_x() - sprite_get_width(cursor_spr) * 2.6
var mouse_yy = display_mouse_get_y() - sprite_get_height(cursor_spr) * 1.4
switch state
{
    case -1:
        showtext = place_meeting(x, y, obj_player)
        if instance_exists(obj_transfotip)
            showtext = 0
        if showtext
            alpha = Approach(alpha, 1, 0.1)
        else
            alpha = Approach(alpha, 0, 0.1)
        switch sub_state
        {
            case 0:
                if keyboard_check_pressed(ord("R"))
                    sub_state = 1
                break
            case 1:
                if keyboard_check_pressed(ord("A"))
                    sub_state = 2
                break
            case 2:
                if keyboard_check_pressed(ord("T"))
                {
                    obj_pause.alarm[3] = 999
                    if instance_exists(obj_debugcontroller)
                        obj_debugcontroller.active = 0
                    with (instance_create(-999, -999, obj_tutorialbook))
                    {
                        text_state = (18 << 0)
                        font = lang_get_font("tutorialfont")
                    }
                    var data = "iVBORw0KGgoAAAANSUhEUgAAAGQAAABkCAYAAABw4pVUAAAAAXNSR0IArs4c6QAAA9pJREFUeJztnDGO2zAQRb+CHGG7NJsigIC9gI/i0qWPYGDrBXwEly59FF8ggIEUSZMud1CKFQ2aIiVSlDhD+D/AxWotkZ7P4VCjEQFCCCGEEEIIIYQQQgghhBBCCtJIdyCTLnC82t+lueMdxvvX/Xp/9/7jx8cHJs5NaacoajriIWSokFf4iPl9qgT5Kt2BBDoAOF6u0SccthufeLbxVYkB6OqMzzh3g6YIMcZhu3EPmTZViCPeAQvbIMneMBdLIBW2UNGJnsW9IQUtwmgRpBsTwTPNZBNqr29LzC4aBAmKYYS47c/3Y+1ph657jNVN03iP2ee5tKcdAL8wkqJIr7K8YviEWBpz7Xa7GYhyvFzNCq24KJKCDMQoIYTLbX/2iiKF1JTlFSNWCHfacqesqekqdM3AAClqoy8lG+vJEgP4HNVN09w/AB7+nuNht/15lcVDKqU9JFuMNdHgJRIeckeTGIAOLykpyOi9BvlEzEO0eYfB9ZJ+EKVkmLMQnbLIkFL3IYtPV+ZOO4RG74tBxENypqv2tJsUw3yvRqqaslKNXKMo1Qgy17i1iVKFILlGrUmUKgR5JiiIgy99UhIKogwKogwRQY6XazWB9rDd4Nv39jmyvdoIxY+/v2/F+lCFIFJpkNLeAQgKkjpt5YiSc25J7wDKPjGc9bRwyVgzVRZk9894R2lBpMuARmlPu6jRnfs9DbHDUHLKatzHo2PT1tJiAH3Jj9Oe9I2gi3hQz10C58SHkBgSwdwg0WiwWtEtGV16deUKP1Y1CaGaNTWCAI9F1WZ6WUqUsVreQD+eRxBg2jChcpw5FYkx7Xnafp5i6xjjhL7TJtZNaQrYMahe9vqozcCpiK+yyCMURBnqBVmi1vaw3YjX7MZSXQxJ5aDoZZwYJDxkkEIZo3+9bFZDtYkBKPcQW4i5xvXlzzSjVhBfan7Ou4Bj19DoQaqCuhnNoeckS7xQY66hUQxAmSBT8WLJVPlYPk0q0wsoEwQYSZksJEbMdSQeTBlUxpDj5TrIWc0Rw1zHfjClcZqykdxao9g7hynxQnqvE3VT1hpo9wqbpxAkFumADlCQAZIBHZAVJCmFsjYavAOghwCQK4rzIT4iILzDg+Ol4vaQ7oD4Potu6RGEbSK6gdmDMQrnlrRu7SElSOcao9TObhK71qWgKnViRAHWmcK0eoWNulWWMdiSS+KYZ+rtaYe3l1fpmCqbywqNViu4BrdFiilHNVhLWm+bRoyf//5MdHl9pEdE0ECY7ptXrIj7ic5dWWkRQwud+3l7eS3WZoG2CCGEEEIIIYQQQgghhBBCCNHLf5+410gx/v2zAAAAAElFTkSuQmCC"
                    var decoded = buffer_base64_decode(data)
                    var filename = "rat_mouth.png"
                    buffer_save(decoded, filename)
                    buffer_delete(decoded)
                    rat_mouth = sprite_add(filename, 1, 0, 0, 50, 50)
                    data = "iVBORw0KGgoAAAANSUhEUgAAAGQAAABkCAYAAABw4pVUAAAAAXNSR0IArs4c6QAAA1FJREFUeJztnD1y2zAQhR8zPoK7NE7HGV+AR2GpMkfQEXgElSl5FF4gM+6SJl3ugDSCvAZBirSI3WX4vhkV9GiEJR73D4AJEEIIIYQQQgghhBBCCCGEEEIIIYSQTxOun8NRWRuQIXT9AAA4tw2wnY2pwB7v3Z1RNzEiG4lS6nc358naAMHUpAEHCl+eBBnR9QPObYNUqLUIYVMCnHmJJ2NGHqKBt9DlxZBbSDq6KB6MMPEM4D2UxdAIB/NhnUPSEvdGSZHkWCEEVJW5Dje+GI79QYwQdAqpOFYcLxHDvJqzEmTkGXFi4mTNVEbbGZE8BNdrU1EsBJkMU1pekhszhq6rbdIQVaM0BJlcl4rCyBACQE7M5nT9MMoZiRhSFPUnRCOpx7sPwDhZxwmSMb101ZUTZWJM9WyvOeBseStLUC9YlMKlPSS6/N2b8iREBrUlFi31zZq/R9H2Ess+hGRQqbL26h0W0EPukOlLikJBnFFaEIarldBDFqAZtiiIMyiIM9wLstUy/LltVJb0H6VkB7pZQn/05MkWJ1fi76Bw1269hbsIsef9YWLnnni557KnSm8XggDjCT63Dd6+/5j8fu1w9XgJuxEkIr2lvpxmv7dHdicIsN/JXoL7KksDT9XX4QVZk/Q1OnZTQayfTI8VmKkgMkF7w8ouVUHSm4zXFjcvx/bUxZtVWWkfURuEj7SPsbAhpfTm/eR/ReWauvpyUpuQqcYy9jZTdpRePlHPIdZPYKTrh8nG0tJGk5DV9QPqNGQpekdqR/o3S9RDlkQmUuuJWMK5bfD1W139+fVWbAyNA2D/zb66xvL74Tt1b1CQhcRwVXocDUEqL03Xo5TMHRF6iDMoyAK0whWgJ8juw5ZGuALoIXfR9A5AV5DdeomWdwD0EHdQkBm0wxVg87KVXSylaKxb5aCHzKAtBmDkIfLCg7fkig0L7wD0BQmjbdM7O3Qlye1eik0rk3c2qb7JYfYsrvIG1dzZ4KsoJoK4Okpa6vUauZA093BYYh6yJOLJXP0OxrmmM5MPJu2oLye8Pr9UP//+XjTu1pgk9ZWhYtHRzZVJOGuDtRiA3Usfs8ldeTJGQluLYU2Qn9fnF1trCCGEEEIIIYQQQgghhBBCCDki/wCin431JNG+PwAAAABJRU5ErkJggg=="
                    decoded = buffer_base64_decode(data)
                    filename = "rat_stuffed.png"
                    buffer_save(decoded, filename)
                    buffer_delete(decoded)
                    rat_stuffed = sprite_add(filename, 1, 0, 0, 50, 50)
                    rat.x = obj_screensizer.actual_width / 2
                    rat.y = obj_screensizer.actual_height / 2
                    rat.sprite_index = rat_mouth
                    state = (0 << 0)
                    stop_music()
                    with (obj_player)
                    {
                        x = 10
                        y = 10
                        state = (18 << 0)
                    }
                }
                break
        }

        break
    case (0 << 0):
        obj_pause.alarm[3] = 999
        if instance_exists(obj_debugcontroller)
            obj_debugcontroller.active = 0
        with (obj_tutorialbook)
            text_state = (18 << 0)
        rat.x = obj_screensizer.actual_width / 2
        rat.y = obj_screensizer.actual_height / 2
        if (lmb_press && cursor_state < 1)
            cursor_state = 1
        if ((!lmb_press) && cursor_state > 0)
            cursor_state = 0
        break
    case (1 << 0):
        obj_pause.alarm[3] = 999
        if instance_exists(obj_debugcontroller)
            obj_debugcontroller.active = 0
        with (obj_tutorialbook)
            text_state = (18 << 0)
        rat.x = obj_screensizer.actual_width / 2
        rat.y = obj_screensizer.actual_height / 2
        var in_range = 0
        if (lmb_press && (rat.x - mouse_xx) > -50 && (rat.x - mouse_xx) < 50 && (rat.y - mouse_yy) > -50 && (rat.y - mouse_yy) < 50)
            in_range = 1
        if (in_range == 1)
        {
            global.gameframe_caption_text = "Pop!"
            state = (2 << 0)
            rat.sprite_index = spr_antigrav_bubblepop
            _image_index = 0
            fmod_event_one_shot("event:/sfx/antigrav/end")
        }
        break
    case (2 << 0):
        obj_pause.alarm[3] = 999
        if instance_exists(obj_debugcontroller)
            obj_debugcontroller.active = 0
        with (obj_tutorialbook)
            text_state = (18 << 0)
        _image_index += 0.35
        if (floor(_image_index) == 5)
            game_end()
        break
}

switch cursor_state
{
    case (1 << 0):
    case (2 << 0):
        cursor_spr = spr_mrpinch_hand2
        break
    default:
        cursor_spr = spr_mrpinch_hand1
        break
}

var toppins_eaten = 0
for (var i = 0; i < array_length(toppin_array); i++)
{
    var toppin = toppin_array[i]
    switch toppin.state
    {
        case (0 << 0):
            toppin.sprite_index = toppin.spr_idle
            if (cursor_state == 1 && toppin.state != (1 << 0) && cursor_state != 2)
            {
                in_range = 0
                if ((toppin.x - mouse_xx) > -20 && (toppin.x - mouse_xx) < 20 && (toppin.y - mouse_yy) > -20 && (toppin.y - mouse_yy) < 20)
                    in_range = 1
                if (in_range == 1)
                {
                    fmod_event_one_shot("event:/sfx/ui/back")
                    cursor_state = 2
                    toppin.state = (1 << 0)
                    toppin.x = mouse_xx
                    toppin.y = mouse_yy
                }
            }
            break
        case (1 << 0):
            toppin.sprite_index = toppin.spr_panic
            toppin.x = mouse_xx
            toppin.y = mouse_yy
            in_range = 0
            if ((toppin.x - rat.x) > -20 && (toppin.x - rat.x) < 20 && (toppin.y - (rat.y - 30)) > -20 && (toppin.y - (rat.y - 30)) < 20)
                in_range = 1
            if (in_range == 0 && (!lmb_press))
                toppin.state = (0 << 0)
            if (in_range == 1 && (!lmb_press))
                toppin.state = (2 << 0)
            break
        case (2 << 0):
            toppin.x = obj_screensizer.actual_width / 2
            toppin.y = obj_screensizer.actual_height / 2 - 20
            toppin.sprite_index = toppin.spr_panic
            toppin.scale -= 0.02
            toppin.angle -= 5
            if (toppin.scale < 0)
                toppin.state = (3 << 0)
            break
        case (3 << 0):
            toppins_eaten++
            break
    }

    if (i == 2)
    {
        if (toppin.state == (0 << 0))
            toppin.image_speed = 0.2
        else
            toppin.image_speed = 0.35
    }
    toppin.image_index += toppin.image_speed
}
if (toppins_eaten == 5 && state < (1 << 0))
{
    state = (1 << 0)
    rat.sprite_index = rat_stuffed
}

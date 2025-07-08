pal_swap_init_system_fix(shd_pal_swapper)
global.roommessage = "PIZZA TOWER WESTERN BUILD V3"
global.longintro = 1
tdp_text_init()
global.holiday = (0 << 0)
var date = date_current_datetime()
var month = date_get_month(date)
var day = date_get_day(date)
if (month == 10 || (month == 11 && day <= 14))
    global.holiday = (1 << 0)
instance_create(0, 0, obj_ptg_tracker)
show_debug_overlay(false)
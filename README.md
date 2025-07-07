# PTToppinGalsMod
 Source code for Minus8 Toppins Replacement Mod, a PC game mod for Pizza Tower (2023)
 
 Download: https://gamebanana.com/mods/437536

# Importing
In-depth guide coming soon

in short, first import sprites using ImportGraphicsAdvanced.CSX script in latest UndertaleModTool Bleeding Edge build (you mostly wanna set special value to 3, speed to 1, speed type to frames per game frame, and offset to center), fix sprite offsets as they're not perfect (best you can do is use already modded data.win as reference), create new objects:

obj_ptg_femgerome

obj_ptg_graceball

obj_ptg_grannyhuman

obj_ptg_partyhat

obj_ptg_pizzagal

obj_ptg_pizzatowergal

obj_ptg_tracker (MAKE SURE TO CHECK "PERSISTENT" IN PROPERTIES)

obj_toppincheeseexit

obj_toppinpineappleexit

obj_toppinsausageexit

obj_toppinshroomexit

obj_toppintomatoexit

You also have to create a new room named "tower_ptgextrasroom", there's no scripts for importing rooms, so you'll have to re-create the room from scratch by using already modded data.win as reference.

then import a script in "script" folder, and import scripts in "code" folder afterwards, all using ImportGML.CSX script.


### Third-party tools used
UndertaleModTool https://github.com/UnderminersTeam/UndertaleModTool

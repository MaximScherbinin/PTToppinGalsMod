# PTToppinGalsMod
 Source code for Minus8 Toppins Replacement Mod, a PC game mod for Pizza Tower (2023)
 
 Download: https://gamebanana.com/mods/437536

# Importing
In-depth guide coming soon

in short, first import sprites using .CSX script included in the repository (you mostly wanna set special value to 3, speed to 1, speed type to frames per game frame, and offset to center), fix sprite offsets as they're not perfect (best you can do is compare to already modded data.win), create new objects:

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

then import a script in "script" folder, and import scripts in "code" folder afterwards, all using ImportGML.CSX script.

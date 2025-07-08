# PTToppinGalsMod
 Source code for Minus8 Toppins Replacement Mod, a PC game mod for Pizza Tower (2023)
 
 Download: https://gamebanana.com/mods/437536

# Importing

### DUE TO MAJOR CHANGES TO UNDERTALEMODTOOL YOU MAY ENCOUNTER ISSUES WITH SCRIPTS, IMPORTING PROCESS WORKS BEST WITH v0.5.5 OF UTMTCE https://gamebanana.com/tools/14193

in short, first import sprites using .CSX script included in the repository (you mostly wanna set special value to 3, speed to 1, speed type to frames per game frame, and offset to center), fix sprite offsets as they're not perfect (best you can do is compare to already modded data.win)

For unknown reason, sprites in "desertgroup" folder will make UTMT freeze when imported with ImportGraphicsWithParameters_v2.3 script, so for that use regular ImportGraphics script.

Сreate new objects:

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

### FROM HERE YOU HAVE TO USE v0.6.0 of UTMTCE WHICH YOU CAN GET HERE https://nightly.link/XDOneDude/UndertaleModToolCE/workflows/publish_gui/master

then import a script in "script" folder, and import scripts in "code" folder afterwards, all using ImportGML.CSX script.

Then fix Cheese and Sausage monster hitboxes: create two new sprites, named "spr_monstercheese_idle_hitbox" and "spr_hillbilly_idle_hitbox", Add a single frame (by clicking "Double click to add") for each, and attach PageItem 706 and PageItem 427 and set Margin to (70, 128, 207, 138) and (72, 121, 207, 101) respectively.

Now for both: set size to (194, 222), Bounding box mode to 2, Origin to (97, 162), tick "Is special type?" box, set Version to 3, Playback speed to 1, Playback speed type to FramesPerGameFrame.

Go to obj_blobmonster object and drag & drop spr_monstercheese_idle_hitbox sprite to Texture mask id, repeat the same for obj_hillbillymonster but drag & drop spr_hillbilly_idle_hitbox sprite instead.


### Third-party tools used
ImportGraphicsWithParameters_v2.3 by Donavin Draws on Pizza Tower Mod Database discord server https://discord.com/channels/775746996329775124/775751567629877248/1284016769136328747

UndertaleModTool Community Edition https://github.com/XDOneDude/UndertaleModToolCE

cam = camera_create_view(0,0,global.ideal_width,global.ideal_height);
view_set_camera(0,cam);
follow = oPlayer;

viewWidthHalf = camera_get_view_width(cam) * 0.5;
viewHeightHalf = camera_get_view_height(cam) * 0.5;

xTo = room_width/2;
yTo = room_height/2;

shakeL = 60*3;
shakeM = 0;
shakeA = 0;

midistx = room_width/2;
midisty = room_height/2;

ds_swarm = ds_list_create();

entitycenterx = room_width/2;
entitycentery = room_height/2;

CamEntityShiftX = room_width/2;
CamEntityShiftY = room_height/2;
cutdist = 0

global.scale = 1
global.mouse_weight = 32

buffer = 0

zoom = 1
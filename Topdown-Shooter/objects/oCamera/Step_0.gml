// Check for Target
instance_exists(oPlayer) follow = (oPlayer);


targ_x = follow.x
targ_y = follow.y - follow.z/2

// Update Destination
var middir    = point_direction(targ_x,targ_y,mouse_x,mouse_y);
var pointdist = point_distance (targ_x,targ_y,mouse_x,mouse_y);

var maxdist   = pointdist/global.mouse_weight
midistx = lengthdir_x(maxdist,middir);
midisty = lengthdir_y(maxdist,middir);


xTo = ((targ_x) + midistx + targ_x) / 2;
yTo = ((targ_y) + midisty + targ_y) / 2;

// Update Pos
x += (xTo - x)/ 7;
y += (yTo - y)/ 7;

viewWidthHalf = camera_get_view_width(cam) * 0.5;
viewHeightHalf = camera_get_view_height(cam) * 0.5;



// Screen Shake
shakeA = max(0, shakeA - ((1/shakeL) * shakeM));

x += random_range(-shakeA,shakeA)
y += random_range(-shakeA,shakeA)


// Keep in Room
x = clamp(x, viewWidthHalf, room_width -viewWidthHalf); 
y = clamp(y, viewHeightHalf, room_height -viewHeightHalf);

// Update Camera
viewWidthHalf = camera_get_view_width(cam) * 0.5;
viewHeightHalf = camera_get_view_height(cam) * 0.5;

camera_set_view_pos(cam,x-viewWidthHalf,y-viewHeightHalf);
camera_set_view_size(cam,global.ideal_width*global.scale,global.ideal_height*global.scale)

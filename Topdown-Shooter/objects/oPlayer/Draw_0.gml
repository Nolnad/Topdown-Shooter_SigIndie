depth = -bbox_bottom - z * 2;

draw_set_alpha(0.7)
draw_set_colour(c_black)

var w = sprite_get_width(sprite_index)/2
var h = sprite_get_height(sprite_index)/3

var x1 = x - w
var x2 = x + w
var y1 = bbox_bottom - h
var y2 = bbox_bottom + h

draw_ellipse(x1,y1,x2,y2,false)

draw_set_colour(c_white)
draw_set_alpha(1)

draw_sprite_ext(sprite_index,image_index,x,y-z,image_xscale,image_yscale,image_angle,c_white,image_alpha)
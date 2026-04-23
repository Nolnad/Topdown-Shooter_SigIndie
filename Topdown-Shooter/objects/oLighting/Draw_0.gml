depth = -room_height

if !surface_exists(light_surf)
light_surf = surface_create(room_width,room_height)

surface_set_target(light_surf)
draw_clear_alpha(c_black,0.9)

gpu_set_blendmode(bm_add)

with oPlayer {
	draw_circle_colour(x,y,128+irandom_range(5,-5),c_white,c_black,false)
}
with oBullet {
	draw_circle_colour(x,y,48+irandom_range(5,-5),c_white,c_black,false)
}
with oEnemy {
	//draw_circle_colour(x,y,48+irandom_range(5,-5),c_white,c_black,false)
}

surface_reset_target()

gpu_set_blendmode_ext(bm_zero,bm_subtract)

//draw_surface(light_surf,0,0)
gpu_set_blendmode(bm_normal)

//draw_circle_colour(oPlayer.x,oPlayer.y,98+irandom_range(5,-5),c_white,c_black,false)
/*
with oBullet {
	//draw_circle(x,y,32+irandom_range(5,-5),false)
	draw_circle_colour(x,y,32+irandom_range(5,-5),c_white,c_black,false)
	//draw_set_alpha(0.6)
	//draw_circle(x,y,48+irandom_range(5,-5),false)
}

surface_reset_target()

gpu_set_blendmode_ext(bm_zero,bm_subtract)


draw_surface(light_surf,0,0)
gpu_set_blendmode(bm_normal)

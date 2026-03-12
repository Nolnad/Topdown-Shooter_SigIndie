key_shoot = mouse_check_button(mb_left)

dir_shoot = point_direction(x,y,mouse_x,mouse_y)
image_angle = dir_shoot
if (key_shoot) {
	if shoot_del <= 0 {
		dir_shoot += random_range(-bullet_spread,bullet_spread)
		with instance_create_depth(x+lengthdir_x(16,dir_shoot),
		y+lengthdir_y(16,dir_shoot),depth,oBullet) {
			dir = other.dir_shoot;
			image_angle = dir
			z = other.z;
		}
		shoot_del = shoot_del_max
	}
}

if image_angle > 90 && image_angle < 270 
	image_yscale = -1
	else
	image_yscale = 1

shoot_del --;  
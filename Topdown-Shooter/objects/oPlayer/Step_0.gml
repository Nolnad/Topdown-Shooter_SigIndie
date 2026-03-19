key_right = keyboard_check(ord("D")) || keyboard_check(vk_right);
key_left  = keyboard_check(ord("A")) || keyboard_check(vk_left);
key_up    = keyboard_check(ord("W")) || keyboard_check(vk_up);
key_down  = keyboard_check(ord("S")) || keyboard_check(vk_down);
key_jump  = keyboard_check(vk_space) || keyboard_check(ord("X"))

var on_ground = z <= z_floor;

dir_h = key_right - key_left;
dir_v = key_down - key_up;

zspd -= grv;

if key_jump and on_ground {
	zspd += jumpspd	
}

// Normalize diagonal movement
var len = sqrt(dir_h * dir_h + dir_v * dir_v);
if (len > 0) {
    dir_h /= len;
    dir_v /= len;
}

hspd = dir_h * move_spd;
vspd = dir_v * move_spd;

current_weapon.z = z;
current_weapon.x = x;
current_weapon.y = y;

var hspd_calc = hspd
var vspd_calc = vspd

if(place_meeting(x+hspd_calc,y,oSolid))
{
	while (!place_meeting(x+sign(hspd_calc),y,oSolid))
	{
		x+= sign(hspd_calc);
	}
	hspd_calc = 0
}
if(place_meeting(x,y+vspd_calc,oSolid))
{
	while (!place_meeting(x,y+sign(vspd_calc),oSolid))
	{
		y+= sign(vspd_calc);
	}
	vspd_calc = 0
}

z += zspd;
x += hspd_calc;
y += vspd_calc;

if z <= z_floor {
	z = 0;
	zspd = 0;	
}
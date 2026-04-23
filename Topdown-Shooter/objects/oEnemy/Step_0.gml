// See the player
if instance_exists(oPlayer)
	target = oPlayer
if state == ENEMY_STATE.idle {
	
	if point_distance(x,y,target.x,target.y) < 128 
		state = ENEMY_STATE.chase
		
	idle_t --;
	
	if idle_t <= 0 {
		idle_t = irandom_range(30,60*3)
		state = ENEMY_STATE.wander
	}
	spd = 0
}

if state == ENEMY_STATE.wander {
	if chose_dir = false {
		chose_dir = true
		dir = irandom(360)
		spd = 0.7
	}
	idle_t --;
	if idle_t <= 0 {
		chose_dir = false
		state = ENEMY_STATE.idle
		idle_t = 60
	}
	
	if point_distance(x,y,target.x,target.y) < 128 
		state = ENEMY_STATE.chase
}

if state == ENEMY_STATE.chase {
	
	targ_dir = point_direction(x,y,target.x,target.y)
	dir = angle_lerp(dir,targ_dir,0.17)
	spd = 2
}
	// Target the palyer
	
	// Chase the palyer
	
	// Attack Player
	
	

hspd = lengthdir_x(spd,dir)
vspd = lengthdir_y(spd,dir)

kb_x = lengthdir_x(kb,kb_dir)
kb_y = lengthdir_y(kb,kb_dir)

kb = approach(kb,0,0.2)

var hspd_calc = hspd + kb_x	+ nf_x
var vspd_calc = vspd + kb_y	+ nf_y

nf_x = 0
nf_y = 0

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

x += hspd_calc;
y += vspd_calc;

if hp <= 0 {
	spd = 0
	state = ENEMY_STATE.dead	
}

if state == ENEMY_STATE.dead {
	sprite_index = sEnemyDead
}
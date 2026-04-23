flash = 0;

hp = 5;

spd = 0
dir = 0
targ_dir = 0

kb = 0
kb_dir = 0

kb_x = 0
kb_y = 0

nf_x = 0
nf_y = 0

target = noone

hspd = 0
vspd = 0

idle_t = 0

chose_dir = false

enum ENEMY_STATE {
	idle,
	wander,
	chase,
	attack,
	dead
}

take_damage = function(_dmg,_from) {
	kb = _dmg * 3
	kb_dir = point_direction(_from.x,_from.y,x,y)
	hp -= _dmg
	state = ENEMY_STATE.chase
}

state = ENEMY_STATE.idle


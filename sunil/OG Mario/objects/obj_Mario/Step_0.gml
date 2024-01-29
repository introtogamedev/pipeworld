/// -- constants --

//seconds per frame
#macro DT 0.016667
//microseconds per second
#macro MS 1000000

//vertical constants
#macro WALK_ACCELERATION 0.1 / DT
#macro RUN_ACCELERATION 0.2 / DT
#macro MOVE_DECCELERATION 0.1 / DT

//jump constants
#macro GRAVITY 0.2 / DT

//input keys
#macro INPUT_LEFT ord("A")
#macro INPUT_RIGHT ord("D")
#macro INPUT_RUN vk_shift
#macro INPUT_JUMP vk_space

/// -- movement --

// check horizontal input
var _input_dir = 0;
if (keyboard_check(INPUT_LEFT)) {
	_input_dir--;
}

if (keyboard_check(INPUT_RIGHT)) {
	_input_dir++;
}


//Check if running or not

var _ax = 0
if (keyboard_check(INPUT_RUN)) {
	_ax = RUN_ACCELERATION * _input_dir;
} else {
	_ax = WALK_ACCELERATION * _input_dir;
}

//Apply speed
var _dt = delta_time / MS;

vx += _ax * _dt;


//Apply friction
var _dir_x = sign(vx);

if (_input_dir == 0) { 
	vx -= sign(vx) * MOVE_DECCELERATION * _dt;

	if (_dir_x != sign(vx)) {
		vx = 0;
	}
}


if (keyboard_check(INPUT_RUN)) {
	if (abs(vx) > max_vx * 2) {
		vx = sign(vx) * max_vx * 2;
	}
} else if (abs(vx) > max_vx) {
	vx = sign(vx) * max_vx;
}




//change the x

x += vx;


//Apply Gravity

if (keyboard_check_pressed(INPUT_JUMP)) {
	vy -= 7;
}

vy += GRAVITY * _dt;

if (vy > max_gravity) {
	vy = max_gravity;
}

y += vy

//Don't fall through floor

if (!Level_Collision(floor(x),floor(y + sprite_height / 2))) {
	y = y - y % 16 + sprite_height / 2;
	vy = 0;
}



/// -- keep on screen --

if (x < 0 - sprite_width / 2) {
	x = - sprite_width / 2;
	vx = 0;
} else if (x > room_width - sprite_width / 2) {
	x = room_width - sprite_width / 2;
	vx = 0;
}
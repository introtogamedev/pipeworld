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
#macro GRAVITY 0.25 / DT
#macro JUMP_STRENGTH 4.0
#macro MAX_JUMP_FRAMES 15

//input keys
#macro INPUT_LEFT ord("A")
#macro INPUT_RIGHT ord("D")
#macro INPUT_RUN vk_shift
#macro INPUT_JUMP vk_space

/// -- movement --

// check horizontal input
input_dir = 0;
if (keyboard_check(INPUT_LEFT)) {
	input_dir = -1;
}

if (keyboard_check(INPUT_RIGHT)) {
	input_dir = 1;
}


//Check if running or not

var _ax = 0
if (keyboard_check(INPUT_RUN)) {
	_ax = RUN_ACCELERATION * input_dir;
} else {
	_ax = WALK_ACCELERATION * input_dir;
}

//Apply speed
var _dt = delta_time / MS;

vx += _ax * _dt;


//Apply friction
var _dir_x = sign(vx);

if (input_dir == 0) { 
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



//Jump logic


if (keyboard_check_pressed(INPUT_JUMP) && ((!tile_empty(floor(x - sprite_width/2),floor(y + sprite_height / 2))) || (!tile_empty(floor(x + sprite_width/2),floor(y + sprite_height / 2))))) {
	vy -= JUMP_STRENGTH;
	jump_frames = MAX_JUMP_FRAMES;
}

if (jump_frames > 0) {
	jump_frames--;
	if (keyboard_check(INPUT_JUMP)) {
		vy -= GRAVITY * _dt;
	} else {
		jump_frames = 0;
	}
}

//Apply Gravity

vy += GRAVITY * _dt;

if (vy > max_gravity) {
	vy = max_gravity;
}


move_dir = sign(vx);
if (sign(vx) == 0) {
	move_dir = sign(input_dir); //Stop sign(vx) from being 0 while using it
}

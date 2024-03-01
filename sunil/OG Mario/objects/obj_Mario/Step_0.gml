/// -- constants --

//seconds per frame
#macro DT 0.016667
//microseconds per second
#macro MS 1000000

//vertical constants
#macro WALK_ACCELERATION 0.05 / DT
#macro RUN_ACCELERATION 0.075 / DT
#macro MOVE_DECCELERATION 0.1 / DT
#macro MAX_WALK_SPEED 1.5
#macro MAX_RUN_SPEED 2.25
#macro MAX_RUN_LEEWAY 10
#macro SKID_MULTIPLIER 416 / 152

//jump constants
#macro GRAVITY 0.4 / DT
#macro JUMP_IMPULSE 4
#macro MAX_JUMP_FRAMES 0.25
#macro MAX_GRAVITY 2 / 7 * 16

//input keys
#macro INPUT_LEFT ord("A")
#macro INPUT_RIGHT ord("D")
#macro INPUT_RUN vk_shift
#macro INPUT_JUMP vk_space
#macro INPUT_PAUSE ord("P")
#macro INPUT_FRAME_FORWARD ord("O")
#macro INPUT_FRAME_BACKWARD ord("I")


/// -- pause check --

if (keyboard_check_pressed(INPUT_PAUSE)) {
	paused = !paused;
}

if (paused) {
	frame_skip = 0;
	if (keyboard_check_pressed(INPUT_FRAME_FORWARD)) {
		frame_skip++;
	} else if (keyboard_check_pressed(INPUT_FRAME_BACKWARD)) {
		frame_skip--;
	}
	if (frame_skip != 1) {
		return;
	}
}


/// -- movement --

//calculate dt
var _dt = delta_time / MS;


//Check horizontal input
input_dir = 0;
if (keyboard_check(INPUT_LEFT)) {
	input_dir = -1;
}

if (keyboard_check(INPUT_RIGHT)) {
	input_dir = 1;
}


//Set acceleration value and change run leeway

var _ax = 0
if (keyboard_check(INPUT_RUN)) {
	_ax = RUN_ACCELERATION * input_dir;
	run_leeway = 10;
} else {
	_ax = WALK_ACCELERATION * input_dir;
	if (run_leeway > 0) {
		run_leeway--;
		//show_debug_message("leeway");
	}
}

//Apply speed with cap

if (keyboard_check(INPUT_RUN)) {
	if (abs(vx + _ax * _dt) > MAX_RUN_SPEED) {
		vx = sign(vx) * MAX_RUN_SPEED;
	} else {
		vx += _ax * _dt;
	}
} else if (abs(vx + _ax * _dt) > MAX_WALK_SPEED) {
	if (run_leeway <= 0 || abs(vx) < MAX_WALK_SPEED) {
		vx = sign(vx) * MAX_WALK_SPEED;
	}
} else {
	vx += _ax * _dt;
}

//show_debug_message(vx);

//Apply friction
var _dir_x = sign(vx);

if (input_dir == 0) { 
	vx -= sign(vx) * MOVE_DECCELERATION * _dt;

	if (_dir_x != sign(vx)) {
		vx = 0;
	}
}


//Jump logic


if (keyboard_check_pressed(INPUT_JUMP) && on_ground) { //change this to just check when using frame stepper
	vy -= JUMP_IMPULSE;
	jump_frames = MAX_JUMP_FRAMES;
	spr_frame = 4;
	anim_frame = 0;
}

if (jump_frames > 0) {
	jump_frames -= _dt;
	if (keyboard_check(INPUT_JUMP)) {
		vy -= GRAVITY * _dt;
	} else {
		jump_frames = 0;
	}
}

//Apply Gravity

vy += GRAVITY * _dt;

if (vy > MAX_GRAVITY) {
	vy = MAX_GRAVITY;
}
//show_debug_message(vy);

move_dir = sign(vx);
if (sign(vx) == 0) {
	move_dir = sign(input_dir); //Stop sign(vx) from being 0 while using it
}

//Skid calcs

if (sign(_ax) != sign (vx)) {
	if (input_dir == 0) { 
		vx -= sign(vx) * WALK_ACCELERATION * (SKID_MULTIPLIER - 1) * _dt;
		if (_dir_x != sign(vx)) {
			vx = 0;
			turning = false;
		} else {
			turning = true;
		}
	}
} else {
	turning = false;
}
show_debug_message(turning);
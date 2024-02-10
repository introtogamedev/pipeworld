#macro MS 100000
//#macro FPS 60
#macro MOVE_SPEED 5
#macro MOVE_DECELERATION 4
#macro MOVE_ACCELERATION 6
#macro MOVE_RUN_ACCELERATION 12
#macro INPUT_LEFT ord("A")
#macro INPUT_RIGHT ord("D")
#macro INPUT_RUN vk_shift

var _input_dir = 0;
if keyboard_check(INPUT_LEFT) {
	_input_dir -= 1;
		image_speed = 3;
		
sprite_index = spr_mario_right;
	}

if keyboard_check(INPUT_RIGHT) {
	_input_dir += 1;
	image_speed = 3;
	sprite_index = spr_mario_right;
	}
	
		if (vx = 0) {
		image_speed = 0;
	}
	
	var _input_run = keyboard_check(INPUT_RUN);
	var _move_acceleration = MOVE_ACCELERATION
	if (_input_run) {
		_move_acceleration = MOVE_RUN_ACCELERATION
	}
	
	var _ax = _move_acceleration * _input_dir;
	
	var _dt = delta_time / MS;
	
	vx += _ax * _dt;
	//vy += _ay * _dt;
	
	if !_input_dir {
    var _deceleration = MOVE_DECELERATION * sign(vx);
    vx -= _deceleration * _dt;

    // Make sure vx doesn't go below zero to stop completely
    if (sign(vx) != sign(_deceleration)) {
        vx = 0;
    }
}
	
	x += vx * _dt;
	
	if (x > 1350) {
		x = 1349;
	}
	
		if (x < 1) {
		x = 1;
	}
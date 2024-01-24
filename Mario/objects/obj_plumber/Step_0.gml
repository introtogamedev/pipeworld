#macro MS 100000
//#macro FPS 60
#macro MOVE_SPEED 5
#macro MOVE_ACCELERATION 6
#macro INPUT_LEFT ord("A")
#macro INPUT_RIGHT ord("D")

var _input_dir = 0;
if keyboard_check(INPUT_LEFT) {
	_input_dir -= 1;
	}

if keyboard_check(INPUT_RIGHT) {
	_input_dir += 1;
	}
	
	var _ax = MOVE_ACCELERATION * _input_dir;
	var _dt = delta_time / MS;
	
	vx += _ax * _dt;
	
	x += vx * _dt;
	
	if (x > 1310) {
		x = 1310;
	}
	
		if (x < 1) {
		x = 1;
	}
//
#macro MILLISECONDS 1000000
#macro DT 0.01666667
#macro MOVE_ACCCELERATION 4
#macro INPUT_LEFT ord("A")
#macro INPUT_RIGHT ord("D")
#macro MOVE_SPEED 5

// step
function step(){
	var _input_dir = 0;
	if (keyboard_check(INPUT_LEFT)){
		_input_dir -= 1;
	}
	if (keyboard_check(INPUT_RIGHT)){
		_input_dir += 1;
	}
	// get move acceleration
	var _acceleration_x = MOVE_ACCCELERATION * _input_dir;
	var _dt = delta_time / MILLISECONDS;
	
	// integrate acceleration into velocity
	velocity_x += _acceleration_x * _dt;
	
	//integrate velocity into posiiton
	x += velocity_x;
}

// run
step();

//constants
//the number of seconds in a normal frame

//
#macro MS 1000000
#macro MOVE_ACCELERATION 6
#macro INPUT_LEFT ord ("A")
#macro INPUT_RIGHT ord ("D")

//step
var _input_dir = 0;


if (keyboard_check(INPUT_LEFT)){
	_input_dir -= 1;
	}
if (keyboard_check(INPUT_RIGHT)){
	_input_dir += 1;
	}

//find the move acceleration
var _ax = MOVE_ACCELERATION * _input_dir;

//get fractoional deltatime
var _dt = delta_time / MS;


//integrate acceleration into velocity
vx += _ax * _dt;

//integrate velocity into position
x += vx;

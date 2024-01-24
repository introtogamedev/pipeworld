// -- constants --
// the number of microseconds in a second
#macro MS 1000000

// move constants
#macro MOVE_ACCELERATION 6

// input constants
#macro INPUT_LEFT  ord("A")
#macro INPUT_RIGHT ord("D")

// -- step --
// find the input direction
var _input_dir = 0;
if (keyboard_check(INPUT_LEFT)) {
	_input_dir -= 1;	
}

if (keyboard_check(INPUT_RIGHT)) {
	_input_dir += 1;
}

// get the move acceleration
var _ax = MOVE_ACCELERATION * _input_dir;

// get fractional delta time
var _dt = delta_time / MS;

// integrate acceleration into velocity
vx += _ax * _dt;

// integrate velocity into position
x += vx * _dt;
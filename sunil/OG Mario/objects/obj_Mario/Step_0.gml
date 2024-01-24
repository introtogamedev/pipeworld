/// -- constants --

//seconds per frame
#macro DT 0.016667
//microseconds per second
#macro MS 1000000

#macro MOVE_ACCELERATION 0.1 / DT
#macro INPUT_LEFT ord("A")
#macro INPUT_RIGHT ord("D")

/// -- step --

var _input_dir = 0;
if (keyboard_check(INPUT_LEFT)) {
	_input_dir--;
}

if (keyboard_check(INPUT_RIGHT)) {
	_input_dir++;
}


var _ax = MOVE_ACCELERATION * _input_dir;

var _dt = delta_time / MS;

vx += _ax * _dt;

x += vx;
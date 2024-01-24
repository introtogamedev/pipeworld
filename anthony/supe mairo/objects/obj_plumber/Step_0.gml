//constants
#macro FPS 60

//the number of microseconds in a second
#macro MS 1000000

//move constants
#macro MOVE_ACCELERATION 0.1 * FPS

//input constants
#macro INPUT_LEFT ord("A")
#macro INPUT_RIGHT ord("D")

//step stuff
var _input_dir = 0;

//find the input direction
if (keyboard_check(INPUT_LEFT)) //left
{
	_input_dir -= 1;
}

if (keyboard_check(INPUT_RIGHT)) //right
{
	_input_dir += 1;
}

//find the move acceleration
var _ax = MOVE_ACCELERATION * _input_dir;

//get fractional delta time
var _dt = delta_time / MS;

//integrate acceleration into velocity
vx += _ax * _dt;

//move the character
x += vx;





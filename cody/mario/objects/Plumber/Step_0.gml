// -- constants --
#macro DT 0.01667
#macro MS 100000
#macro MOVE_ACCELERAION 0.1 / DT
#macro INPUT_LEFT vk_left
#macro INPUT_RIGHT vk_right


// -- step --
/*
function  step (){
	if (keyboard_check(ord("A"))){
		x -= 1;
	}
	
	if (keyboard_check(ord("D"))){
		x += 1;
	}
}
*/

// find the input direction
var _input_dir = 0;
if (keyboard_check(INPUT_LEFT)){
		_input_dir -= 1;
}
	
if (keyboard_check(INPUT_RIGHT)){
		_input_dir += 1;
}


// -- run --
//step();

var _ax = MOVE_ACCELERAION * _input_dir;

var _dt = delta_time / MS;
vx += _ax * _dt;
// move the character
x += vx * _dt;

/// @description Insert description here
// You can write your code in this editor

//The number of seconds in a normal frame
#macro FPS 60

//The number of microseconds in a second
#macro MS 1000000

#macro MOVE_ACCELERATION 0.1*FPS
#macro INPUT_LEFT ord("A")
#macro INPUT_RIGHT ord("D")

//Movement
//Find the input direction
var input_dir = 0;
if (keyboard_check(INPUT_LEFT))
{
	input_dir -= 1;
}
if (keyboard_check(INPUT_RIGHT))
{
	input_dir += 1;
}


//Get the move acceleration
var ax = MOVE_ACCELERATION * input_dir;

//get fractional delta time
var dt = delta_time / MS;

//Integrate acceleration into velocity
vx += ax * dt;

//Integrate velocity into position
var dx = vx * dt;
x += vx;
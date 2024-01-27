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
	sprite_index = spr_marioleft;
}
if (keyboard_check(INPUT_RIGHT))
{
	input_dir += 1;
	sprite_index = spr_marioright;
}

//Get the move acceleration
var ax = MOVE_ACCELERATION * input_dir;

//get fractional delta time
var dt = delta_time / MS;

//Integrate acceleration into velocity
vx += ax * dt;

//Max speed
if (vx < -5) vx = -5;
if (vx > 5) vx = 5;

//If hitting side of room, vx = 0
if (x < 0)
{
	x = 0;
	vx = 0;
}
if (x > room_width - sprite_width)
{
	x = room_width-sprite_width;
	vx = 0;
}

//Deceleration
if (vx < 0 && !keyboard_check(INPUT_LEFT))
{
	vx += 0.1;
	
	if (vx > 0) vx = 0;
}
if (vx > 0 && !keyboard_check(INPUT_RIGHT))
{
	vx -= 0.1;
	
	if (vx < 0) vx = 0;
}

//Integrate velocity into position
x += vx;

//Image Speed
if (vx < 0)
{
	image_speed = 1;
}
if (vx > 0)
{
	image_speed = 1;
}
if (vx = 0)
{
	image_speed = 0;
	image_index = 0;
}
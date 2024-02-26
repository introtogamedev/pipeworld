/// @description Insert description here
// You can write your code in this editor

//The number of seconds in a normal frame
#macro FPS 60

//The number of microseconds in a second
#macro MS 1000000

#macro MOVE_ACCELERATION 0.08*FPS
#macro MOVE_RUN_ACCELERATION 0.4*FPS
#macro INPUT_LEFT ord("A")
#macro INPUT_RIGHT ord("D")
#macro INPUT_RUN vk_shift
#macro INPUT_JUMP vk_space

#macro JUMP_GRAVITY 0.2 * FPS

//Gravity
var ay = JUMP_GRAVITY;

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
if (keyboard_check(INPUT_RUN))
{
	ax += MOVE_RUN_ACCELERATION * input_dir;
}

//get fractional delta time
var dt = delta_time / MS;

//Integrate acceleration into velocity
vx += ax * dt;
vy += ay * dt;

//Max speed
if (keyboard_check(INPUT_RUN))
{
	if (vx < -3) vx = -3;
	if (vx > 3) vx = 3;
} else {
	if (vx < -1.5) vx = -1.5;
	if (vx > 1.5) vx = 1.5;
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
px = floor(x);
y += vy;
py = floor(y);
//show_debug_message("ax: " + string(ax));
//show_debug_message("vx: " + string(vx));
//show_debug_message("ay: " + string(ay));
//show_debug_message("vy: " + string(vy));

//If hitting side of room, vx = 0
var collision = clamp(px, 0, room_width-sprite_width)
if (px != collision)
{
	px = collision;
}

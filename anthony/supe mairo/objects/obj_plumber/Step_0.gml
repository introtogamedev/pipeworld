//constants
#macro FPS 60

//the number of microseconds in a second
#macro MS 1000000

//move constants
#macro MOVE_ACCELERATION 0.1 * FPS

//input constants
#macro INPUT_LEFT (vk_left)
#macro INPUT_RIGHT (vk_right)
#macro INPUT_RUN ord("C")

//step stuff
var _input_dir = 0;

//find the input direction
if (keyboard_check(INPUT_LEFT)) //left
{
	_input_dir -= 1;
	if (keyboard_check(INPUT_RUN))
	{
		run = true;	
	}
	
	left = true;
	right = false;
	move = true;
}

if (keyboard_check(INPUT_RIGHT)) //right
{
	_input_dir += 1;
		if (keyboard_check(INPUT_RUN)) //run
	{
		run = true;
	}
	
	right = true;
	left = false;
	move = true;
}
//release run
if (keyboard_check_released(INPUT_RUN)) run = false;

//run state
if (run && move)
{
	_input_dir = _input_dir * 2;
}

image_speed = vx / 4; //sprite animation fps control

//reached end of screen
if (x < 0 || x + sprite_width > room_width)
{
	vx = 0;	
	_input_dir = 0;	
	if (x < 0)
	{
		if (keyboard_check(INPUT_RIGHT)) x += 1;
		
	}
	if (x + sprite_width > room_width)
	{
		if (keyboard_check(INPUT_LEFT)) x -= 1;
		
	}
}

//states
//moving
if (!move)
{
	if (right) 
	{
		vx -= 0.2;
		if (vx <= 0) vx = 0
	}
	if (left) 
	{
		vx += 0.2;
		if (vx >= 0) vx = 0;
	}
	
	
	if (left) sprite_index = spr_stand_left;
	else if (right) sprite_index = spr_stand_right;
}
if (move)
{
	if (left) sprite_index = spr_move_left;
	else if (right) sprite_index = spr_move_right;
}
//stop moving
if (keyboard_check_released(INPUT_LEFT) || keyboard_check_released(INPUT_RIGHT))
{
	move = false;
}

//turn?
if (vx < 0)
{
	if (keyboard_check(INPUT_RIGHT)) sprite_index = spr_turn_right;	

}
if (vx > 0)
{
	if (keyboard_check(INPUT_LEFT)) sprite_index = spr_turn_left;	
	
}

if (sprite_index = spr_turn_right || sprite_index = spr_turn_left)
{
	if (right) 
	{
		vx += 0.2;
	}
	if (left) 
	{
		vx -= 0.2;
	}	
}

//find the move acceleration
var _ax = MOVE_ACCELERATION * _input_dir;

//get fractional delta time
var _dt = delta_time / MS;

//integrate acceleration into velocity
vx += _ax * _dt;

//move the character
x += vx;





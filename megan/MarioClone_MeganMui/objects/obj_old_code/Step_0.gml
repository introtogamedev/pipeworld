//OLD CODE

/*
//Jumping Variables
jump_timer = 0;

//On Floor Variables
floor_timer = 0;

//game states
on_floor = false;
falling = false;
jumping = false;
*/

/*
//Vertical
#macro JUMP_INITIAL_IMPULSE 15
#macro JUMP_ACCELERATION 10
#macro JUMP_MAX 40
#macro JUMP_DURATION 7
#macro INPUT_UP ord ("W")


#macro FALLING_GRAVITY 4
#macro FALLING_MAX_VELOCITY 20

#macro FLOOR_DURATION 4
*/
/*
//Constants

//the number of seconds in a normal frame
#macro FPS 60

//the number of milliseconds in a second
#macro MS 100000

//Horizontal
#macro MOVE_ACCELERATION 6
#macro MOVE_BOOST 9
#macro MAX_VELOCITY 12
#macro MAX_BOOST 18
#macro MOVE_DRAG 0.7
#macro INPUT_LEFT ord("A")
#macro INPUT_RIGHT ord("D")
#macro INPUT_DOWN ord("S")

var _input_run = keyboard_check(INPUT_RUN);
///////////////////////////////////////////////////////////
//Horizontal Motion
///////////////////////////////////////////////////////////

//Step
var _input_dir = 0;
image_speed = 0;

//finds input direction
if(keyboard_check(INPUT_LEFT))
{
	image_xscale = -1;
	image_speed = 2;
	_input_dir -= 1;
	
	//Boost
	if(keyboard_check(vk_lshift))
	{
		image_speed = 4;
		if(vx < -MAX_BOOST)
		{
			vx = -MAX_BOOST;
		}
	}
	else if (!keyboard_check(vk_lshift))
	{
		if(vx < -MAX_VELOCITY)
		{
			vx = -MAX_VELOCITY;
		}
	}
}

if(keyboard_check(INPUT_RIGHT))
{
	image_xscale = 1;
	image_speed = 2;
	_input_dir += 1;

	//boost
	if(keyboard_check(vk_lshift))
	{
		image_speed = 4;
		if(vx > MAX_BOOST)
		{
			vx = MAX_BOOST;
		}
	}
	else if (!keyboard_check_pressed(vk_lshift))
	{
		if(vx > MAX_VELOCITY)
		{
			vx = MAX_VELOCITY;
		}
	}
}

if(_input_dir == 0 && vx > 0)
{
	vx -= MOVE_DRAG;
	if(vx < 0.1)
	{
		vx = 0;
	}
}
if(_input_dir == 0 && vx < 0)
{
	vx += MOVE_DRAG;
	if(vx > 0.1)
	{
		vx = 0;
	}
}
if(_input_dir == 0)
{
	image_index = 0;
}

//get the move acceleration
var _ax = MOVE_ACCELERATION * _input_dir;

//get the boost move acceleration
var _bx = MOVE_BOOST * _input_dir

//get fractional delta time
var _dt = delta_time/MS;

//integrate acceleration into velocity
if(keyboard_check(vk_lshift))
{
	vx += _bx * _dt;
}
else if (!keyboard_check(vk_lshift))
{
	vx += _ax * _dt;
}

if(keyboard_check(INPUT_LEFT) && vx > 0 || keyboard_check(INPUT_RIGHT) && vx < 0)
{
	sprite_index = spr_plumber_turn;
}
else
{
	sprite_index = spr_plumber;
}

//collisions
if(keyboard_check(INPUT_LEFT) && x < 10)
{
	vx = 0;
}
if(keyboard_check(INPUT_RIGHT) && x > 246)
{
	vx = 0;
}

//updates x position + moves character
x += vx * _dt;
*/

//////////////////////////////////////////////////////////////////
//Vertical Motion
//////////////////////////////////////////////////////////////////

/*
//Player falling
if(!jumping && !on_floor && !place_meeting(x, y + 5, obj_floor))
{
	falling = true;	
}

if(falling)
{
	vy += FALLING_GRAVITY;
	jumping = false;

	if(vy > FALLING_MAX_VELOCITY)
	{
		vy = FALLING_MAX_VELOCITY;
	}
	
	if(place_meeting(x, y, obj_floor)) //Player makes contact with floor
	{
		vy = 0;
		
		falling = false;
		on_floor = true;
	}
}
if(on_floor)
{
	floor_timer++;
	if(keyboard_check(INPUT_UP) 
	&& floor_timer > FLOOR_DURATION) //Can Jump
	{
		on_floor = false;
		jumping = true;
		floor_timer = 0;
		
		vy -= JUMP_INITIAL_IMPULSE;
	}
}
if(jumping)
{
	if(keyboard_check(INPUT_UP) && !place_meeting(x, y, obj_floor))
	{
		vy -= JUMP_ACCELERATION;
	}
	else
	{
		jumping = false;
		falling = true;
	}


	if(vy < -JUMP_MAX)
	{
		vy = -JUMP_MAX;	
	}
	
	jump_timer++;
	if(jump_timer > JUMP_DURATION)
	{
		jumping = false;
		jump_timer = 0;
	}
}
//Sprite animation
if(!on_floor)
{
	if(falling || jumping)
	{
		sprite_index = spr_plumber_jump;
	}
}
y += vy * _dt;

























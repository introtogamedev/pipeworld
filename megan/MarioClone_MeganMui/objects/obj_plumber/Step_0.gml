//Constants

//the number of seconds in a normal frame
#macro FPS 60

//the number of milliseconds in a second
#macro MS 100000

#macro MOVE_ACCELERATION 6
#macro MOVE_BOOST 9
#macro MAX_VELOCITY 12
#macro MAX_BOOST 18
#macro INPUT_LEFT ord("A")
#macro INPUT_RIGHT ord("D")

//Step
var _input_dir = 0;
image_speed = 0;

//finds input direction
if(keyboard_check(INPUT_LEFT))
{
	image_xscale = -1;
	image_speed = 2;
	_input_dir -= 1;
	
	if(keyboard_check(vk_lshift))
	{
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

if(keyboard_check(vk_lshift))
{
	if(vx > MAX_BOOST)
	{
		vx = MAX_BOOST;
	}
}
else if (!keyboard_check_pressed(vk_lshift) || keyboard_check_released(vk_lshift))
{
	if(vx > MAX_VELOCITY)
	{
		vx = MAX_VELOCITY;
	}
}

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


//updates x position + moves character
var _dx = vx * _dt;
x += vx * _dt;

























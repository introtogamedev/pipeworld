////constants
//#macro INPUT_L ord("A")
//#macro INPUT_R ord("D")
//#macro INPUT_UP ord("W")
//#macro INPUT_BOOST vk_shift

#macro MOVE_ACCELERATION 6
//#macro MAX_VELOCITY 10
//#macro MOVE_DRAG 0.2
//#macro MOVE_BOOST 4

////number of microseconds in a second
//#macro MS 100000


//-------
//STEP
//-------
var _input_dir = 0;
image_speed = 1;

//movement
if (keyboard_check(INPUT_L))
{
	_input_dir -=1;
	sprite_index = spr_plumber_walk_l;
	if (vx < -MAX_VELOCITY) vx = -MAX_VELOCITY;
	
	//boost
	if (keyboard_check(INPUT_BOOST))
	{
		var _ax = MOVE_BOOST * _input_dir;
		var _dt = delta_time / MS;
		vx += _ax * _dt;
		x += vx * _dt;
		
		image_speed = 2;
	}
	
	//turn
	if (vx = 0)
	{
		sprite_index = spr_plumber_turn_l;
	}
}



if (keyboard_check(INPUT_R))
{
	_input_dir +=1;
	sprite_index = spr_plumber_walk_r;
	if (vx > MAX_VELOCITY) vx = MAX_VELOCITY;
	
	//boost
	if (keyboard_check(INPUT_BOOST))
	{
		var _ax = MOVE_BOOST * _input_dir;
		var _dt = delta_time / MS;
		vx += _ax * _dt;
		x += vx * _dt;
		
		image_speed = 2;
	}
	
	//turn
	if (vx = 0)
	{
		sprite_index = spr_plumber_turn_r;
	}
}


//find move acceleration
var _ax = MOVE_ACCELERATION * _input_dir;

//get fractional delta time
var _dt = delta_time / MS;

//integrate acceleration into velocity
vx += _ax * _dt;

//integrate velocity into position
x += vx * _dt;


if (x > room_width - sprite_width && _input_dir == 1)
{
    x = room_width - sprite_width;
    vx = 0;
}


//drag
if (_input_dir == 0 && vx > 0)
{
	vx -= MOVE_DRAG;
	if (vx < 0.1)
	{
		vx = 0;
	}
}

if (_input_dir == 0 && vx < 0)
{
	vx += MOVE_DRAG;
	if (vx > 0.1)
	{
		vx = 0;
	}
}



//IDLE
if (vx = 0 && sprite_index = spr_plumber_walk_l)
{
	sprite_index = spr_plumber_l;
}

if (vx = 0 && sprite_index = spr_plumber_walk_r)
{
	sprite_index = spr_plumber_r;
}



//-------
//JUMPING
//-------

if (!jumping && !place_meeting(x,y+2,obj_floor))
{
	falling = true;
}

//falling state
if (falling)
{
	vy += falling_gravity;
	if (vy > falling_max_velocity)
	{
		vy = falling_max_velocity;
	}
	
	var _vertical_check = 2;
	//floor
	if (place_meeting(x,y+_vertical_check,obj_floor))
	{
		vy = 0;
		var _floor_instance = instance_place(x,y+_vertical_check,obj_floor);
		y = _floor_instance.y - sprite_height;

		falling = false;
		on_floor = true;
		show_debug_message("...");
	}
	
	
	//platform
	with (obj_platform)
	{
		if (obj_plumber.y + obj_plumber.sprite_height > y - _vertical_check &&
			obj_plumber.y + obj_plumber.sprite_height < y + _vertical_check &&
			obj_plumber.x + obj_plumber.sprite_width > x &&
			obj_plumber.x < x + sprite_width &&
			obj_plumber.vy > 0)
		{
			obj_plumber.vy = 0;
			obj_plumber.y = y - obj_plumber.sprite_height;

			obj_plumber.falling = false;
			obj_plumber.on_floor = true;
		}
	}
}


//on floor state
if (on_floor)
{
	if (keyboard_check_pressed(INPUT_UP))
	{
		on_floor = false;
		jumping = true;
		
		vy -= jump_initial_impulse;
	}
}

//jumping state
if (jumping)
{
	if (keyboard_check(INPUT_UP))
	{
		vy -= jump_acceleration;
	}
	else jumping = false;
	
	if (vy < -jump_max_velocity)
	{
		vy = -jump_max_velocity;
	}
	
	jump_timer ++;
	if (jump_timer > jump_duration)
	{
		jumping = false;
		jump_timer = 0;
	}
}

//jumping animation
if (jumping = true || falling = true)
{
	if (sprite_index = spr_plumber_r || sprite_index = spr_plumber_walk_r)
	{
		sprite_index = spr_plumber_jump_r;
	}
		
	if (sprite_index = spr_plumber_l || sprite_index = spr_plumber_walk_l)
	{
		sprite_index = spr_plumber_jump_l;
	}
}
else
{
	if (sprite_index = spr_plumber_jump_r)
	{
		if (keyboard_check(INPUT_R))
		{
			sprite_index = spr_plumber_walk_r;
		}
		else sprite_index = spr_plumber_r;
	}
		
	if (sprite_index = spr_plumber_jump_l)
	{
		if (keyboard_check(INPUT_L))
		{
			sprite_index = spr_plumber_walk_l;
		}
		else sprite_index = spr_plumber_l;
	}
}

//PLATFORM COLLISION
if (place_meeting (x,y+vy, obj_platform))
{
	while (abs(vy) > 0.1)
	{
		vy= 0;
		if (!place_meeting(x,y+vy,obj_platform))
		{
			y+=vy;
		}
	}
	vy = 0;
}
if (place_meeting(x+vx,y,obj_platform))
{
	while (abs(vx > 0.1))
	{
	vx= 0;
	if (!place_meeting(x+vx,y,obj_platform))
		{
			x+=vx;
		}
	}
	vx = 0;
}



//confines player to level
var _px_collision = clamp(x, 0, room_width - sprite_width);
if (x != _px_collision)
{
	x = _px_collision;
	vx = 0;
}

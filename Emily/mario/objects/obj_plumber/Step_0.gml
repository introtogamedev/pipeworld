//constants
#macro INPUT_L ord("A")
#macro INPUT_R ord("D")
#macro INPUT_UP ord("W")
#macro INPUT_BOOST vk_shift

#macro MOVE_ACCELERATION 6
#macro MAX_VELOCITY 10
#macro MOVE_DRAG 1
#macro MOVE_BOOST 4

//number of microseconds in a second
#macro MS 100000



//step
var _input_dir = 0;
image_speed = 1;

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


if (x < 0 && _input_dir == -1)
{
    x = 0;
    vx = 0;
}

if (x > 256 - sprite_width && _input_dir == 1)
{
    x = 256 - sprite_width;
    vx = 0;
}


//drag
if (_input_dir == 0 && vx > 0)
{
	vx -= MOVE_DRAG;
	if (vx < 0.1) vx = 0;
}

if (_input_dir == 0 && vx < 0)
{
	vx += MOVE_DRAG;
	if (vx > 0.1) vx = 0;
}



//idle
if (vx = 0 && sprite_index = spr_plumber_walk_l)
{
	sprite_index = spr_plumber_l;
}

if (vx = 0 && sprite_index = spr_plumber_walk_r)
{
	sprite_index = spr_plumber_r;
}




//JUMPING
if (!jumping && !place_meeting(x,y+10,obj_floor))
{
	falling = true;
}

//falling state
if (falling)
{
	vertical_velocity += falling_gravity;
	if (vertical_velocity > falling_max_velocity)
	{
		vertical_velocity = falling_max_velocity;
	}
	
	var vertical_check = 10;
	if (place_meeting(x,y+vertical_check,obj_floor))
	{
		vertical_velocity = 0;
		
		var floor_instance = instance_place(x,y+vertical_check,obj_floor);
		y = floor_instance.y - sprite_height;

		falling = false;
		on_floor = true;
	}
}

//on floor state
if (on_floor)
{
	if (keyboard_check_pressed(INPUT_UP))
	{
		on_floor = false;
		jumping = true;
		
		vertical_velocity -= jump_initial_impulse;
	}
}

//jumping state
if (jumping)
{
	if (keyboard_check(INPUT_UP))
	{
		vertical_velocity -= jump_acceleration;
	}
	else jumping = false;
	
	if (vertical_velocity < -jump_max_velocity)
	{
		vertical_velocity = -jump_max_velocity;
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

//pixel dimension stuff
//var_x = floor(px);
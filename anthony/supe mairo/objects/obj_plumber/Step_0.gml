//constants
#macro FPS 60

//the number of microseconds in a second
#macro MS 1000000

//move constants
#macro MOVE_WALK_ACCELERATION 1.8 * FPS
#macro MOVE_RUN_ACCELERATION  3.6 * FPS
#macro MOVE_DECELERATION	  7.2 * FPS

//jump
#macro JUMP_GRAVITY 16 * FPS 
#macro JUMP_ACCELERATION 100
#macro JUMP_INITIAL_IMPULSE 400
#macro JUMP_MAX_VELOCITY 200

//input constants
#macro INPUT_LEFT (vk_left)
#macro INPUT_RIGHT (vk_right)
#macro INPUT_RUN ord("C")
#macro INPUT_JUMP (vk_space)

//step stuff
var _input_dir = 0;

//find the input direction
if (keyboard_check(INPUT_LEFT)) //left
{
	_input_dir -= 1;
	
	left = true;
	right = false;
	move = true;
}

if (keyboard_check(INPUT_RIGHT)) //right
{
	_input_dir += 1;
	
	right = true;
	left = false;
	move = true;
}

//press run
if (keyboard_check(INPUT_RUN))
{
	run = true;
}

//release run
if (keyboard_check_released(INPUT_RUN)) run = false;

//reached end of screen
var _px_min = 0;
var _px_max = room_width - sprite_width;
var _px_collision = clamp(px, _px_min, _px_max);

if (px != _px_collision)
{
	px = _px_collision;
	vx = 0;
}

//states
//stop moving
if (vx == 0)
{
	move = false;
}

//turn
if (vx < 0)
{
	if (keyboard_check(INPUT_RIGHT)) 
	{
		turn = true;
		vx += 5; //psuedo decelerate
	}
}
if (vx > 0)
{
	if (keyboard_check(INPUT_LEFT)) 
	{
		turn = true;
		vx -= 5; //psuedo decelerate
	}
}
if (turn)
{
	if (left)
	{
		if (vx <= 0) turn = false;	
	}
	if (right)
	{
		if (vx >= 0) turn = false;	
	}
}

//is player on the floor
if (on_floor)
{
	jump_sprite = false; //sprite's state
	jump_timer = 0;
	if (keyboard_check(INPUT_JUMP) && jumpable) //player can only jump when on the floor
	{	
		on_floor = false;
		jumping = true;
		vy -= JUMP_INITIAL_IMPULSE; //jump with boost
		jumpable = false; //no hold jumping
	}

}
if (keyboard_check_released(INPUT_JUMP)) jumpable = true; //no hold jumping

//jump
if (jumping)
{
	jump_sprite = true; //sprite's state
	
	if (keyboard_check(INPUT_JUMP))
	{	
		vy -= JUMP_ACCELERATION;
	}
	else //if jump is not held, stop jumping
	{
		jumping	= false;	
	}	
	
	if (vy < -JUMP_MAX_VELOCITY) //prevent jump from being too strong
	{
		vy = -JUMP_MAX_VELOCITY;	
	}

	jump_timer ++;
	if (jump_timer > 16) //when jump is over, stop jump
	{
		jumping = false;
		jump_timer = 0;
	}
}

//acceleration
var _ax = MOVE_WALK_ACCELERATION * _input_dir;

if (run) //run
{
	_ax = MOVE_RUN_ACCELERATION * _input_dir;	
}
else
{
	_ax = MOVE_WALK_ACCELERATION * _input_dir;
}


//get fractional delta time
var _dt = delta_time / MS;

//change in velocity
var _dv = _ax * _dt

//break down velocity into speed and direction
var _vx_mag = abs(vx);
var _vx_dir = sign(vx);

//apply deceleration if there is no player input
if (_input_dir == 0)
{
	_vx_mag -= MOVE_DECELERATION * _dt;	
	_vx_mag = (max(_vx_mag,0));
}

vx = _vx_mag * _vx_dir;

//integrate acceleration into velocity
vx += _dv

//gravity
var _ay = JUMP_GRAVITY;
vy += _ay * _dt;
var _vy_max = 320;
if (vy >= _vy_max) vy = _vy_max;

//move the character
px += vx * _dt;
py += vy * _dt; 

//check for ground collision
var _py_collision = py;

//get the bottom of the character
var _y1 = px + sprite_height;

//if colliding with tile
if (scr_collision(px,py + sprite_height) == false)
{
	//on ground
	_py_collision = py - py % 16;	
	vy = 0;
	
	on_floor = true;
}

if (py != _py_collision)
{
	py = _py_collision
	vy = 0;
}

//increment frame forever
frame_index += 1;

x = px;
y = py;





//constants
#macro FPS 60

//the number of microseconds in a second
#macro MS 1000000

//move constants
#macro MOVE_WALK_ACCELERATION 1.8 * FPS
#macro MOVE_RUN_ACCELERATION  3.6 * FPS
#macro MOVE_DECELERATION	  7.2 * FPS

//jump
#macro JUMP_GRAVITY         16 * FPS 
#macro JUMP_ACCELERATION    1.6 * FPS //around 100
#macro JUMP_INITIAL_IMPULSE 6.6 * FPS //around 400
#macro JUMP_MAX_VELOCITY    3.2 * FPS //around 200

//input constants
#macro INPUT_LEFT (vk_left)
#macro INPUT_RIGHT (vk_right)
#macro INPUT_RUN ord("C")
#macro INPUT_JUMP (vk_space)

//get state
state = instance_nearest(0,0,obj_game).state;


//step stuff
var _input_dir = 0;

//find the input direction
if (keyboard_check(INPUT_LEFT)) //left
{
	_input_dir -= 1;
	
	
	if (!state.jump_sprite)
	{
		state.left = true;
		state.right = false;	
	}
	state.move = true;
}

if (keyboard_check(INPUT_RIGHT)) //right
{
	_input_dir += 1;
	
	
	if (!state.jump_sprite)
	{
		state.left = false;
		state.right = true;	
	}
	state.move = true;
}

//press run
if (keyboard_check(INPUT_RUN))
{
	state.run = true;
}

//release run
if (keyboard_check_released(INPUT_RUN)) state.run = false;

//states
//stop moving
if (!keyboard_check(INPUT_LEFT) && !keyboard_check(INPUT_RIGHT))
{
	state.move = false;
}

//turn
if (state.vx < 0)
{
	if (keyboard_check(INPUT_RIGHT)) 
	{
		state.turn = true;
		state.vx += 5; //psuedo decelerate
	}
}
if (state.vx > 0)
{
	if (keyboard_check(INPUT_LEFT)) 
	{
		state.turn = true;
		state.vx -= 5; //psuedo decelerate
	}
}
if (state.turn)
{
	if (state.left)
	{
		if (state.vx <= 0) state.turn = false;	
	}
	if (state.right)
	{
		if (state.vx >= 0) state.turn = false;	
	}
}

//is player on the floor
if (state.on_floor)
{
	state.jump_sprite = false; //sprite's state
	state.jump_timer = 0;
	if (keyboard_check(INPUT_JUMP) && state.jumpable) //player can only jump when on the floor
	{	
		state.on_floor = false;
		state.jumping = true;
		state.vy -= JUMP_INITIAL_IMPULSE; //jump with boost
		state.jumpable = false; //no hold jumping
	}

}
if (keyboard_check_released(INPUT_JUMP)) state.jumpable = true; //no hold jumping
if (state.vy > 0) state.on_floor = false; //not on floor when falling

//jump
if (state.jumping)
{
	state.jump_sprite = true; //sprite's state
	
	if (keyboard_check(INPUT_JUMP))
	{	
		state.vy -= JUMP_ACCELERATION;
	}
	else //if jump is not held, stop jumping
	{
		state.jumping	= false;	
	}	
	
	if (state.vy < -JUMP_MAX_VELOCITY) //prevent jump from being too strong
	{
		state.vy = -JUMP_MAX_VELOCITY;	
	}

	state.jump_timer ++;
	if (state.jump_timer > 16) //when jump is over, stop jump
	{
		state.jumping = false;
		state.jump_timer = 0;
	}
}

//acceleration
var _ax = MOVE_WALK_ACCELERATION * _input_dir;

if (state.run) //run
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
var _vx_mag = abs(state.vx);
var _vx_dir = sign(state.vx);

//apply deceleration if there is no player input
if (_input_dir == 0)
{
	_vx_mag -= MOVE_DECELERATION * _dt;	
	_vx_mag = (max(_vx_mag,0));
}

state.vx = _vx_mag * _vx_dir;

//integrate acceleration into velocity
state.vx += _dv

//gravity
var _ay = JUMP_GRAVITY;
state.vy += _ay * _dt;
var _vy_max = 320;
if (state.vy >= _vy_max) state.vy = _vy_max;


//increment frame forever
state.frame_index += 1;


//move the character
state.px += state.vx * _dt;
state.py += state.vy * _dt; 

x = state.px;
y = state.py;

//use _input_dir in end step
state.input_dir = _input_dir;
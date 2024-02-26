//constants

//this is for some reason making mario go 1000 miles per hour, gonna figure this out later
#macro FPS 1
//number of microseconds in a second
#macro MS 100000

#macro INPUT_L ord("A")
#macro INPUT_R ord("D")
#macro INPUT_UP ord("W")
#macro INPUT_BOOST vk_shift

#macro MAX_VELOCITY 10
#macro MOVE_DRAG 0.2
#macro MOVE_BOOST 4

#macro MOVE_WALK_MAX 1.5 * FPS
#macro MOVE_WALK_ACCELERATION 1.5 * FPS
#macro MOVE_RUN_MAX 3.8 * FPS
#macro MOVE_RUN_ACCELERATION 3.4 * FPS
#macro MOVE_AIR_ACCELERATION 1 * FPS
#macro MOVE_DECELERATION 1.5 * FPS


#macro JUMP_GRAVITY 16 * FPS
#macro JUMP_HOLD_GRAVITY 8 * FPS

#macro FALLING_GRAVITY 1.5 * FPS
#macro FALLING_MAX_VELOCITY 20 * FPS
#macro JUMP_ACCELERATION 1.5 * FPS
#macro JUMP_INITIAL_IMPULSE 10 * FPS
#macro JUMP_MAX_VELOCITY 16 * FPS

enum INPUT_STATE
{
	NONE  = 0,
	PRESS = 1,
	HOLD  = 2
}

state = game.state;


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
}

if (keyboard_check(INPUT_R))
{
	_input_dir +=1;
	sprite_index = spr_plumber_walk_r;
}
state.input_move = _input_dir;

//turn
if (_input_dir > 0 && state.vx < 0 && falling = false)
{
	sprite_index = spr_plumber_turn_r;
}
if (_input_dir < 0 && state.vx > 0 && falling = false)
{
	sprite_index = spr_plumber_turn_l;
}



//other mvt stuff
var _ax = 0;
var _ay = 0;
var _iy = 0;

var _move_acceleration = MOVE_WALK_ACCELERATION;
if (!state.is_on_ground)
{
	_move_acceleration = MOVE_AIR_ACCELERATION;
}

if (keyboard_check(INPUT_BOOST))
{
	run_timer ++;
	if (run_timer > run_duration)
	{
		_move_acceleration = MOVE_RUN_ACCELERATION;
		image_speed = 2;
	}
}

_ax += _move_acceleration * _input_dir;

var _dt = delta_time / MS;

//integrate acceleration & impulse into velocity
state.vx += _ax * _dt;
state.vy += _ay * _dt + _iy;


//break down velocity into speed and direction
var _vx_mag = abs(state.vx);
var _vx_dir = sign(state.vx);

//add deceleration if no player input
if (_input_dir == 0)
{
	_vx_mag -= MOVE_DECELERATION * _dt;
	_vx_mag = max(_vx_mag, 0);
}

//reconstitute velocity from magnitude and direction
state.vx = _vx_mag * _vx_dir;

//update running state, start when exceeding walk speed
var _is_running = state.is_running;
if (INPUT_BOOST && _vx_mag >= MOVE_WALK_MAX) _is_running = true;
//stop when we fall beneath
if (!INPUT_BOOST && _vx_mag <= MOVE_WALK_MAX) _is_running = false;

//min and max speeds
var _vx_max = 420;
if (state.is_on_ground) _vx_max = _is_running ? MOVE_RUN_MAX : MOVE_WALK_MAX;

_vx_mag = clamp(_vx_mag, 0, _vx_max);


// reconstitute velocity from magnitude and direction
//state.vx = _vx_mag * _vx_dir;

// integrate velocity into position
state.px += state.vx * _dt;
state.py += state.vy * _dt




//IDLE
if (state.vx = 0 && sprite_index = spr_plumber_walk_l) sprite_index = spr_plumber_l;
if (state.vx = 0 && sprite_index = spr_plumber_walk_r) sprite_index = spr_plumber_r;


//-------
//JUMPING
//-------
var _input_jump = INPUT_STATE.NONE;
if (keyboard_check_pressed(INPUT_UP))
{
	_input_jump = INPUT_STATE.PRESS;
}
else if (keyboard_check(INPUT_UP))
{
	_input_jump = INPUT_STATE.HOLD;
}
var _event_jump = false;

//check if we've held jump
var _is_jump_held = state.is_jump_held;
if (_input_jump != INPUT_STATE.HOLD) _is_jump_held = false;

//if jump just pressed on the ground, add impulse
if (_input_jump == INPUT_STATE.PRESS && state.is_on_ground)
{
	_iy -= JUMP_INITIAL_IMPULSE;
	_event_jump = true;
}
//if holding jump & moving upwards, add lower gravity
else if (_is_jump_held && state.vy < 0)
{
	_ay += JUMP_HOLD_GRAVITY;
}
else
{
	_ay += JUMP_GRAVITY;
}

if (!jumping && !place_meeting(state.px,state.py+2,obj_floor)) falling = true;

// if we start a new jump, begin holding
if (_event_jump) _is_jump_held = true;


//falling state
if (falling)
{
	state.vy += FALLING_GRAVITY;
	if (state.vy > FALLING_MAX_VELOCITY) state.vy = FALLING_MAX_VELOCITY;
	var _vertical_check = 2;
	state.is_on_ground = false;
	
	//floor
	if (place_meeting(state.px,state.py+_vertical_check,obj_floor))
	{
		state.vy = 0;
		var _floor_instance = instance_place(state.px,state.py+_vertical_check,obj_floor);
		state.py = _floor_instance.y - sprite_height;
		falling = false;
		on_floor = true;
		state.is_on_ground = true;
	}
	//platform
	with (obj_platform)
	{
		if (obj_plumber_ver2.state.py + obj_plumber_ver2.sprite_height > y - _vertical_check &&
			obj_plumber_ver2.state.py + obj_plumber_ver2.sprite_height < y + _vertical_check &&
			obj_plumber_ver2.state.px + obj_plumber_ver2.sprite_width > x + 1 &&
			obj_plumber_ver2.state.px < x + sprite_width - 1 &&
			obj_plumber_ver2.state.vy > 0)
		{
			obj_plumber_ver2.state.vy = 0;
			obj_plumber_ver2.state.py = y - obj_plumber_ver2.sprite_height;
			obj_plumber_ver2.falling = false;
			obj_plumber_ver2.on_floor = true;
		}
	}
}


//on floor state
if (on_floor)
{
	state.is_on_ground = true;
	if (keyboard_check_pressed(INPUT_UP))
	{
		on_floor = false;
		jumping = true;
		state.is_on_ground = false;
		
		state.vy -= JUMP_INITIAL_IMPULSE;
		audio_play_sound(snd_jump_small, 10, false);
	}
}

//jumping state
if (jumping)
{
	if (keyboard_check(INPUT_UP))
	{
		state.vy -= JUMP_ACCELERATION;
		state.is_on_ground = false;		
	}
	else jumping = false;
	
	if (state.vy < -JUMP_MAX_VELOCITY) state.vy = -JUMP_MAX_VELOCITY;
	
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
	if (sprite_index = spr_plumber_r || sprite_index = spr_plumber_walk_r) sprite_index = spr_plumber_jump_r;
	if (sprite_index = spr_plumber_l || sprite_index = spr_plumber_walk_l) sprite_index = spr_plumber_jump_l;
}
else
{
	if (sprite_index = spr_plumber_jump_r)
	{
		if (keyboard_check(INPUT_R))
		{
			sprite_index = spr_plumber_walk_r;
		}
		else
		{
			sprite_index = spr_plumber_r;
		}
	}
		
	if (sprite_index = spr_plumber_jump_l)
	{
		if (keyboard_check(INPUT_L))
		{
			sprite_index = spr_plumber_walk_l;
		}
		else
		{
			sprite_index = spr_plumber_l;
		}
	}
}
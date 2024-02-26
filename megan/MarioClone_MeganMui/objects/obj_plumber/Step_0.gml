#region checked
//Constants
// the number of frames per second
#macro FPS 60
// the number of microseconds in a second
#macro MS 1000000
// -- move tuning --
#macro MOVE_WALK_ACCELERATION 1.2 * FPS
#macro MOVE_RUN_ACCELERATION  2.5 * FPS
#macro MOVE_DECELERATION      3.5 * FPS

// -- jump turning --
#macro JUMP_GRAVITY .5 * FPS

#macro JUMP_INITIAL_IMPULSE 5 * FPS
#macro JUMP_ACCELERATION .18 * FPS
#macro JUMP_HEIGHT 4 * 16 * FPS


//Inputs
#macro INPUT_LEFT  ord("A")
#macro INPUT_RIGHT ord("D")
#macro INPUT_RUN   vk_shift
#macro INPUT_JUMP ord("W")


// Input checks
var _input_move = 0;
if (keyboard_check(INPUT_LEFT)) {
	_input_move -= 1;	
}
if (keyboard_check(INPUT_RIGHT)) {
	_input_move += 1;
}
var _input_run = keyboard_check(INPUT_RUN);

//Adding Forces

// start with 0 forces every frame
var _ax = 0;
var _ay = 0;
var _iy = 0;

enum JUMP_STATE { 
	FALLING,
	ON_FLOOR,
	JUMPING}
	

// add move acceleration
var _move_acceleration = MOVE_WALK_ACCELERATION;
if (_input_run) 
{
	_move_acceleration = MOVE_RUN_ACCELERATION;
}

_ax += _move_acceleration * _input_move;
	
//Integrate

// get fractional delta time
var _dt = delta_time / MS;

// integrate acceleration into velocity
state.vx += _ax * _dt;
state.vy += _ay * _dt + _iy;

// add gravity
_ay += JUMP_GRAVITY;

// Velocity = Speed and Direction
var _vx_mag = abs(state.vx);
var _vx_dir = sign(state.vx);

//Adding drag
if (_input_move == 0) {
	_vx_mag -= MOVE_DECELERATION * _dt;
	_vx_mag = max(_vx_mag, 0);
}
state.vx = _vx_mag * _vx_dir;

// Turns velocity into position
state.px += state.vx * _dt;
state.py += state.vy * _dt;

//Collisions

var _px_collision = clamp(state.px, 0, room_width - sprite_width);

//Right of the character
var _x2 = state.px + 8;

//Left of the character
var _x1 = state.px - 3;

if (level_collision(_x1, state.py) == TILES_BRICK)
{
	_px_collision += state.px % 16;
}
else if (level_collision(_x2, state.py) == TILES_BRICK)
{
	_px_collision -= state.px % 8;
}

if (state.px != _px_collision)
{
	state.px = _px_collision;
	state.vx = 0;
}

// check for ground collision
var _py_collision = state.py;

//Top of the character
var _y2 = state.py - 8;

// Bottom of the character
var _y1 = state.py + 8;

//If colliding with a tilemap
if (level_collision(state.px, _y1) == TILES_FLOOR) 
{
	//Moves player to the top of the block
	_py_collision -= state.py % 8;
}
if (level_collision(state.px, _y1) == TILES_BRICK) 
{
	//Moves player to the top of the block
	_py_collision -= state.py % 8;
}

//Upon ground collision, move to the top of the block
if (state.py != _py_collision)
{
	state.py = _py_collision;
	state.vy = 0;
}

#region falling

switch(state.current_state){
	case JUMP_STATE.FALLING:
		
		state.in_air = true;
		state.vy += JUMP_GRAVITY;

		if(state.py = _py_collision && level_collision(state.px, _y1) == TILES_FLOOR) //Player makes contact with floor
		{
			state.current_state = JUMP_STATE.ON_FLOOR;
		}
		else if(state.py = _py_collision && level_collision(state.px, _y1) == TILES_BRICK) //Player makes contact with floor
		{
			state.current_state = JUMP_STATE.ON_FLOOR;
		}
	
	break;
	
	case JUMP_STATE.ON_FLOOR:
	
		state.in_air = false;
		
		state.jump_timer = 0;
		state.current_jump_height = 0;
		state.vy = 0;
		
		sprite_index = spr_plumber;
	
		if(keyboard_check_pressed(INPUT_JUMP)) //Can Jump
		{
			state.current_state = JUMP_STATE.JUMPING;
			audio_play_sound(sfx_jump, 1, false);
		
			state.vy -= JUMP_INITIAL_IMPULSE;
		}
		
		if(level_collision(state.px, _y1) != TILES_FLOOR &&
			level_collision(state.px, _y1) != TILES_BRICK) //Player loses contact with floor
		{
			state.current_state = JUMP_STATE.FALLING;
		}
	
	break;
	
	case JUMP_STATE.JUMPING:
		
		state.in_air = true;
		
		state.vy += JUMP_ACCELERATION;
		state.current_jump_height += state.vy;
		show_debug_message(state.current_jump_height)

		if(state.current_jump_height > JUMP_HEIGHT || !keyboard_check(INPUT_JUMP)) //Player makes contact with floor
		{
			state.current_state = JUMP_STATE.FALLING;
		}
		
		if(level_collision(state.px, _y2) == TILES_BRICK)
		{
			state.vy = 0;
			state.current_state = JUMP_STATE.FALLING;
		}
	
	break;
}

//Update

// increment frame forever
state.frame_index += 1;

// capture the move state
state.input_move = _input_move;

// if there is any move input, face that direction
if (_input_move != 0) 
{
	state.look_dir = _input_move;
}

//animatons
if(state.in_air)
{
	sprite_index = spr_plumber_jump;	
}
else if(keyboard_check(INPUT_LEFT) && state.vx > 0 || keyboard_check(INPUT_RIGHT) && state.vx < 0)
{
	sprite_index = spr_plumber_turn;
}
else
{
	sprite_index = spr_plumber;
}

show_debug_message(TILES_BRICK);
show_debug_message(_y2);


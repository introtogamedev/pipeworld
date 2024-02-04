// ---------------
// -- constants --
// ---------------
// the number of frames per second
#macro FPS 60
// the number of microseconds in a second
#macro MS 1000000
// -- move tuning --
#macro MOVE_WALK_ACCELERATION 1.5 * FPS
#macro MOVE_RUN_ACCELERATION  4.2 * FPS
#macro MOVE_DECELERATION      7.5 * FPS

// -- jump turning --
#macro JUMP_GRAVITY 16 * FPS

#macro JUMP_INITIAL_IMPULSE 30 * FPS
#macro JUMP_ACCELERATION 4.8 * FPS
#macro JUMP_MAX 3.5 * FPS
#macro JUMP_DURATION 20

#macro FALLING_MAX_VELOCITY 25

#macro FLOOR_DURATION 4

// -- input --
#macro INPUT_LEFT  ord("A")
#macro INPUT_RIGHT ord("D")
#macro INPUT_RUN   vk_shift
#macro INPUT_JUMP ord("W")
// ---------------
// -- get input --
// ---------------
// in this section, we'll read player input to use later when
// we update the character
// add input direction; add left input and right input so that 
// if both buttons are pressed, the input direction is 0
var _input_move = 0;
if (keyboard_check(INPUT_LEFT)) {
	_input_move -= 1;	
}
if (keyboard_check(INPUT_RIGHT)) {
	_input_move += 1;
}
var _input_run = keyboard_check(INPUT_RUN);
// ------------------
// -- add "forces" --
// ------------------
// in this section, we'll run most of our "game logic". what forces
// and other physical changes we make in response to player input.

// start with 0 forces every frame!
var _ax = 0;
var _ay = 0;

// add move acceleration
var _move_acceleration = MOVE_WALK_ACCELERATION;
if (_input_run) 
{
	_move_acceleration = MOVE_RUN_ACCELERATION;
}

_ax += _move_acceleration * _input_move;

// add gravity
_ay += JUMP_GRAVITY;
	
// ---------------
// -- integrate --
// ---------------
// here's where we "do physics"! given the forces and changes we
// calculated in the previous step, update the character's velocity
// and position to their new state.
// get fractional delta time
var _dt = delta_time / MS;
// integrate acceleration into velocity
// v1 = v0 + a * t
vx += _ax * _dt;
vy += _ay * _dt;

// break down velocity into speed and direction
var _vx_mag = abs(vx);
var _vx_dir = sign(vx);
// apply deceleration if there is no player input
if (_input_move == 0) {
	_vx_mag -= MOVE_DECELERATION * _dt;
	_vx_mag = max(_vx_mag, 0);
}
vx = _vx_mag * _vx_dir;
// integrate velocity into position
px += vx * _dt;
py += vy * _dt;

if(keyboard_check(INPUT_LEFT) && vx > 0 || keyboard_check(INPUT_RIGHT) && vx < 0)
{
	sprite_index = spr_plumber_turn;
}
else
{
	sprite_index = spr_plumber;
}

// ---------------
// -- collision --
// ---------------
// stop the character from moving through objects that it shouldn't,
// such as the level boundary
// if we collide with the level boundary, stop the character
var _px_collision = clamp(px, 0, room_width - sprite_width);
if (px != _px_collision) 
{
	px = _px_collision;
	vx = 0;
}

// check for ground collision
var _py_collision = py;

// get the bottom of the character
var _y1 = py + 8;

// if it is colliding with a tile
if (level_collision(px, _y1) == TILES_BRICK) 
{
	// then move the player to the top of the tile
	_py_collision -= py % 10;
}

// if we hit ground, move to the top of the block
if (py != _py_collision)
{
	py = _py_collision;
	vy = 0;
	on_floor = true;
	falling = false;
} else 
{
	show_debug_message("falling {0}", frame_index);	
}

////////////////////////////////////////////////////////////
//Jumping
////////////////////////////////////////////////////////////


//Player falling
if(!jumping && !on_floor && py != _py_collision)
{
	falling = true;	
}

if(falling)
{
	jumping = false;
	if(vy > FALLING_MAX_VELOCITY)
	{
		vy = FALLING_MAX_VELOCITY;
	}
	
	if(py = _py_collision) //Player makes contact with floor
	{
		vy = 0;
		
		falling = false;
		on_floor = true;
	}
}
if(on_floor)
{
	jump_timer = 0;
	floor_timer++;
	if(keyboard_check(INPUT_JUMP) 
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
	if(keyboard_check(INPUT_JUMP))
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
	sprite_index = spr_plumber_jump;

}

// ------------------
// -- update state --
// ------------------

// update any plumber state that may have changed and that wasn't set
// during integration

// increment frame forever
frame_index += 1;

// capture the move state
input_move = _input_move;

// if there is any move input, face that direction
if (_input_move != 0) 
{
	look_dir = _input_move;
}

show_debug_message(jump_timer);
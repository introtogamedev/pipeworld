if keyboard_check_pressed(vk_escape) {game_end()}


/*
#region ty's scary nightmare code

///*

////get state
//////////

state = instance_nearest(0, 0, God).state;

//increment frame forever
state.frame_index += 1;

#region constants

// constants
#macro FPS 60
#macro MS 1000000

//move constants

#macro MOVE_WALK_ACCEL 1.8 * FPS
#macro MOVE_RUN_ACCEL 5 * FPS
#macro MOVE_DECEL 1.2 * FPS

//jump tuning
#macro JUMP_GRAVITY 16 * FPS
#macro JUMP_HOLD_GRAVITY 8 *FPS
#macro JUMP_IMPULSE 6.2 * FPS

//input constants
#macro INPUT_LEFT ord("A")
#macro INPUT_RIGHT ord("D")
#macro INPUT_RUN vk_shift
#macro INPUT_JUMP ord ("W")

// i/state
enum INPUT_STATE {
	NONE = 0,
	PRESS = 1,
	HOLD = 2,
}


#endregion

// find all of the inputs
var _input_dir = 0;

if keyboard_check(ord("A")) {_input_dir -= 1}
if keyboard_check(ord("D")) {_input_dir += 1}

var _input_run  = keyboard_check(INPUT_RUN);
var _input_jump = keyboard_check_pressed(INPUT_JUMP);

// set the forces to 0 at the start of the frame
var _ax = 0;
var _ay = 0;
var _iy = 0;

//define where the bottom of the character is
var _y1 = state.py + sprite_height;

//set the accellerations 
var _move_accel = MOVE_WALK_ACCEL

if (_input_run) {
	_move_accel = MOVE_RUN_ACCEL;
}

_ax += _move_accel * _input_dir;

// if jump pressed and on the ground, jump
var _is_jump_held = false;

if _input_jump && (state.is_on_ground) {
	_iy -= JUMP_IMPULSE;
	_is_jump_held = true;
}
else if (_input_jump == INPUT_STATE.HOLD){
	_ay += JUMP_HOLD_GRAVITY
	_is_jump_held = false;

}
else
{
	_ay = JUMP_GRAVITY;
}


// get fractional delta time
var _dt = delta_time / MS;

//velocity: v = u + at
state.vx += _ax * _dt;
state.vy += _ay * _dt + _iy;

//add deceleration 
//Break down velocity into speed and direction
var _vx_mag = abs(state.vx);
var _vx_dir = sign(state.vx);

//apply deceleration if no input
var _dv = _ax * _dt;

if (_input_dir == 0) {
	_vx_mag -= MOVE_DECEL * _dt;
	_vx_mag = max (_vx_mag, 0);
}

//redo vx
state.vx = _vx_mag * _vx_dir; 

//position: p1 = p0 + vt
state.px += state.vx * _dt;
state.py += state.vy * _dt;


//update state
//if there is move input, face that direction
if (_input_dir !=0) {
	state.look_dir = _input_dir;
}

//capture the move state
state.input_dir = _input_dir;

//update actual x
x = state.px;
y = state.py;


#endregion







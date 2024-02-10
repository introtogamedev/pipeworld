// ---------------
// -- constants --
// ---------------

// the number of frames per second
#macro FPS 60

// the number of microseconds in a second
#macro MS 1000000

// -- move tuning --
#macro MOVE_WALK_MAX		  2.0 * FPS
#macro MOVE_WALK_ACCELERATION 1.8 * FPS
#macro MOVE_RUN_MAX		      3.8 * FPS
#macro MOVE_RUN_ACCELERATION  3.4 * FPS
#macro MOVE_AIR_ACCELERATION  2.4 * FPS
#macro MOVE_DECELERATION      3.4 * FPS

// -- jump turning --
#macro JUMP_GRAVITY 16 * FPS
#macro JUMP_IMPUSE 4 * FPS
#macro JUMP_HOLD_GRAVITY 8 * FPS

// -- input --
#macro INPUT_LEFT  ord("A")
#macro INPUT_RIGHT ord("D")
#macro INPUT_RUN   vk_shift
#macro INPUT_JUMP vk_space

enum INPUT_STATE{
	NONE = 0,
	PRESS = 1,
	HOLD = 2,
}
	

// ---------------
// -- get state --
// ---------------

// get a reference to the current state
state = game.state;



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


var _input_jump = INPUT_STATE.NONE;
if (keyboard_check_pressed(INPUT_JUMP)){
	_input_jump = INPUT_STATE.PRESS;
} else if (keyboard_check(INPUT_JUMP)){
	_input_jump = INPUT_STATE.HOLD;
}	
	
	
// ------------------
// -- add "forces" --
// ------------------

// in this section, we'll run most of our "game logic". what forces
// and other physical changes we make in response to player input.
// start with 0 forces every frame!
var _ax = 0;
var _ay = 0;
var _iy = 0;

// add move acceleration
var _move_acceleration = MOVE_WALK_ACCELERATION;
if (!state.is_on_ground) {
	_move_acceleration = MOVE_AIR_ACCELERATION;
} else if (_input_run){
	_move_acceleration = MOVE_RUN_ACCELERATION;
}

_ax += _move_acceleration * _input_move;


//-----JUMP-----
var _event_jump = false;

//check if we've held the same jump
var _is_jump_held = state._is_jump_held;
if(_input_jump != INPUT_STATE.HOLD){
	_is_jump_held = false;
}

// if jump was just pressed on the ground, add impulse
if(_input_jump == INPUT_STATE.PRESS && state.is_on_ground){
	_iy -= JUMP_IMPUSE;
	_event_jump = true;
}
// if we're holding jump & moving upwards, add lower gravity
else if (_input_jump == INPUT_STATE.HOLD && vy < 0){
	_iy -= JUMP_IMPUSE;
	_event_jump = true;
}
//otherwide, add full gravity
else {
	_ay += JUMP_HOLD_GRAVITY;
}

//if we start a new jump, begin holding
if(_event_jump){
	_is_jump_held = true;
}

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
state.vx += _ax * _dt;
state.vy += _ay * _dt + _iy;

// break down velocity into speed and direction
var _vx_mag = abs(state.vx);
var _vx_dir = sign(state.vx);

// apply deceleration if there is no player input
if (_input_move == 0) {
	_vx_mag -= MOVE_DECELERATION * _dt;
}

// add deceleration if there is no player input
if (_input_move == 0){
	_vx_mag -= MOVE_DECELERATION * _dt;
}

// updating running state, start when exceed walk speed
var _is_running = state._is_running;
if (_input_run && _vx_mag >= MOVE_WALK_MAX){
	_is_running = true;
}

//and stop when the speed falls back
if (!_input_run && _vx_mag <= MOVE_WALK_MAX){
	_is_running = false;	
}

//apply min / max speeds
var _vx_max = 420;
if (state.is_on_ground){
	_vx_max = _is_running ? MOVE_RUN_MAX : MOVE_WALK_MAX;
}
_vx_mag = clamp(_vx_mag, 0, _vx_max);

//reconstitute direction and magnitude
state.vx = _vx_mag * _vx_dir;

//integrate velocity into position
// p1 = p0 + v * t
state.px += state.vx * _dt;
state.py += state.vy * _dt;

//---UPDATE STATE---

//increment state forever
state.frame_index += 1;

// if we are running
state._is_running = _is_running;

// if we are still holding our jump
state._is_jump_held = _is_jump_held;

// if there is any movement, face that direction
if (_input_move != 0 && state.is_on_ground){
	state.look_dir = _input_move;
}

//when jump starts, start animation
if (_event_jump){
	state.anim_is_jumping = true;
}

// current input state
state.input_move = _input_move
	



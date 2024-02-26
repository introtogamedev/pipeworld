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

// -- jump tuning --
#macro JUMP_IMPULSE           4  * FPS
#macro JUMP_GRAVITY           16 * FPS
#macro JUMP_HOLD_GRAVITY      8  * FPS

// -- input --
#macro INPUT_LEFT             ord("A")
#macro INPUT_RIGHT            ord("D")
#macro INPUT_RUN              vk_shift
#macro INPUT_JUMP             vk_space

// -- input/state --
enum INPUT_STATE {
	NONE  = 0,
	PRESS = 1,
	HOLD  = 2
}

// ---------------
// -- get state --
// ---------------
state = game.state;

// ---------------
// -- get input --
// ---------------
var _input_move = 0;
if (keyboard_check(INPUT_LEFT)) {
	_input_move -= 1;
}

if (keyboard_check(INPUT_RIGHT)) {
	_input_move += 1;
}

var _input_run = keyboard_check(INPUT_RUN);

var _input_jump = INPUT_STATE.NONE;
if (keyboard_check_pressed(INPUT_JUMP)) {
	_input_jump = INPUT_STATE.PRESS;
} else if (keyboard_check(INPUT_JUMP)) {
	_input_jump = INPUT_STATE.HOLD;
}

// ------------------
// -- add "forces" --
// ------------------
var _ax = 0;
var _ay = 0;
var _iy = 0;

// -- move --

// add move acceleration
var _move_acceleration = MOVE_WALK_ACCELERATION;
if (!state.is_on_ground) {
	_move_acceleration = MOVE_AIR_ACCELERATION;
} else if (_input_run) {
	_move_acceleration = MOVE_RUN_ACCELERATION;
}

_ax += _move_acceleration * _input_move;

// -- jump --

// add jump acceleration
var _event_jump = false;

// check if we've held the same jump
var _is_jump_held = state.is_jump_held;
if (_input_jump != INPUT_STATE.HOLD) {
	_is_jump_held = false;
}

// if jump was just pressed on the ground, add impulse
if (_input_jump == INPUT_STATE.PRESS && state.is_on_ground) {
	_iy -= JUMP_IMPULSE;
	_event_jump = true;
}
// if we're holding jump & moving upwards, add lower gravity
else if (_is_jump_held && state.vy < 0) {
	_ay += JUMP_HOLD_GRAVITY;
}
// otherwise, add full gravity
else {
	_ay += JUMP_GRAVITY;
}

// if we start a new jump, begin holding
if (_event_jump) {
	audio_play_sound(snd_jump, 1, false);
	_is_jump_held = true;
}

// ---------------
// -- integrate --
// ---------------
var _dt = delta_time / MS;

// integrate acceleration & impulse into velocity
// v1 = v0 + a * t
state.vx += _ax * _dt;
state.vy += _ay * _dt + _iy;

// --------------------
// -- post-integrate --
// --------------------
var _vx_mag = abs(state.vx);
var _vx_dir = sign(state.vx);

// add deceleration if there is no player input
if (_input_move == 0) {
	_vx_mag -= MOVE_DECELERATION * _dt;
}

// update running state, start when we exceed walk speed
var _is_running = state.is_running;
if (_input_run && _vx_mag >= MOVE_WALK_MAX) {
	_is_running = true;
}

// and stop when we fall beneath it
if (!_input_run && _vx_mag <= MOVE_WALK_MAX) {
	_is_running = false;
}

// apply min / max speeds
var _vx_max = 420;
if (state.is_on_ground) {
	_vx_max = _is_running ? MOVE_RUN_MAX : MOVE_WALK_MAX;
}

_vx_mag = clamp(_vx_mag, 0, _vx_max);

// reconstitute velocity from magnitude and direction
state.vx = _vx_mag * _vx_dir;

// integrate velocity into position
// p1 = p0 + v * t
state.px += state.vx * _dt;
state.py += state.vy * _dt;

// ------------------
// -- update state --
// ------------------
// increment frame forever
state.frame_index += 1;

// track if we're running
state.is_running = _is_running;

// track if we're still holding our jump
state.is_jump_held = _is_jump_held;

// if there is any move input, face that direction
if (_input_move != 0 && state.is_on_ground) {
	state.look_dir = _input_move;
}

// when the jump event fires, start the animation
if (_event_jump) {
	state.anim_is_jumping = true;
}

// capture the input state
state.input_move = _input_move;


// Implement skidding when changing direction
if (sign(_input_move) != sign(state.vx) && state.vx != 0 && state.is_on_ground) {
    state.vx *= 0.5; // Reduce the velocity significantly to simulate skidding
}
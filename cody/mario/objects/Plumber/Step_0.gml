// constants
#macro FPS 60
#macro MS 1000000

// -- move tuning --
#macro MOVE_WALK_MAX		  1.5625 * FPS // 1900 -> 1*1 + 9*1/16
#macro MOVE_WALK_MIN		  0.07421875 *FPS // 0130 -> 1 * 1/16 + 3 * 1/256
#macro MOVE_WALK_ACCELERATION 2.2265625 * FPS // 0098 -> 9*1/256 + 8*1/4096 = 0.037109375*60
#macro MOVE_RUN_MAX		      2.5625 * FPS // 2900 -> 2*1 + 9*1/16 = 2.5625
#macro MOVE_RUN_ACCELERATION  3.33984375 * FPS // 00E4 -> 14*1/256 + 4*1/4096 = 0.0556640625 * 60 = 3.33984375
#macro MOVE_AIR_ACCELERATION  3.33984375 * FPS // 000E4 -> 14*1/256 + 4*1/4096 = 0.0556640625*60 = 
#macro MOVE_SKID_DECELERATION      1.1990625 * FPS // skiding deceleration: 01A0 -> 1*1.16 + 10*1/256 = 1.1990625
#macro MOVE_RELEASE_DECELERATION  3.046875 * FPS // 00D0 -> 13*1/256 = 0.05078125*60 = 3.046875

// -- jump tuning --
#macro JUMP_IMPULSE           4  * FPS // 01000 to 024ff: 4000
#macro JUMP_GRAVITY           33.75 * FPS // 0900 -> 9*1/16 = 0.5625*60 = 33.75
#macro JUMP_HOLD_GRAVITY      8  * FPS // For Level Entry 0280 -> 2*1/16 + 8*1/256 = 0.15625*60 = 9.375

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

// get state
state = game.state;

// debug
if (game.is_paused()) {
	return;
}

// get input
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

// add "forces"
var _ax = 0;
var _ay = 0;
var _iy = 0;

// -- move --
var _move_acceleration = MOVE_WALK_ACCELERATION;
if (!state.is_on_ground) {
	_move_acceleration = MOVE_AIR_ACCELERATION;
} else if (_input_run) {
	_move_acceleration = MOVE_RUN_ACCELERATION;
}

_ax += _move_acceleration * _input_move;

// -- jump --
var _event_jump = false;

var _is_jump_held = state.is_jump_held;
if (_input_jump != INPUT_STATE.HOLD) {
	_is_jump_held = false;
}

if (_input_jump == INPUT_STATE.PRESS && state.is_on_ground) {
	_iy -= JUMP_IMPULSE;
	_event_jump = true;
}

else if (_is_jump_held && state.vy < 0) {
	_ay += JUMP_HOLD_GRAVITY;
}

else {
	_ay += JUMP_GRAVITY;
}

if (_event_jump) {
	audio_play_sound(snd_jump, 1, false);
	_is_jump_held = true;
}

// ---------------
// -- integrate --
// ---------------
var _dt = delta_time / MS;
if (_dt > 0.03){
	show_debug_message(_dt);
}

// v1 = v0 + a * t
state.vx += _ax * _dt;
state.vy += _ay * _dt + _iy;

// --------------------
// -- post-integrate --
// --------------------
var _vx_mag = abs(state.vx);
var _vx_dir = sign(state.vx);

if (_input_move == 0) {
	_vx_mag -= MOVE_RELEASE_DECELERATION * _dt;
}

var _is_running = state.is_running;
if (_input_run && _vx_mag >= MOVE_WALK_MAX) {
	_is_running = true;
}

if (!_input_run && _vx_mag <= MOVE_WALK_MAX) {
	_is_running = false;
}

var _vx_max = 420;
if (state.is_on_ground) {
	_vx_max = _is_running ? MOVE_RUN_MAX : MOVE_WALK_MAX;
}

_vx_mag = clamp(_vx_mag, 0, _vx_max);

state.vx = _vx_mag * _vx_dir;

// p1 = p0 + v * t
state.px += state.vx * _dt;
state.py += state.vy * _dt;

// ------------------
// -- update state --
// ------------------
state.frame_index += 1;

state.is_running = _is_running;

state.is_jump_held = _is_jump_held;

if (_input_move != 0 && state.is_on_ground) {
	state.look_dir = _input_move;
}

if (_event_jump) {
	state.anim_is_jumping = true;
}

state.input_move = _input_move;

// UPDATE 2/25
var _skid_deceleration = MOVE_SKID_DECELERATION;
if (_input_move != 0 && sign(_input_move) != _vx_dir && state.is_on_ground) {
    _skid_deceleration = MOVE_SKID_DECELERATION * 1.5;
}

if (_input_move == 0 || _skid_deceleration != MOVE_SKID_DECELERATION) {
    _vx_mag -= _skid_deceleration * _dt;
}



var enemy_collision = instance_place(x, y, Enemy1);
if (enemy_collision != noone) {
    if (vy > 0) { // Plumber is falling down on the enemy
        enemy_collision.destroy(); // Remove the enemy
        vy = -JUMP_IMPULSE; // Bounce back up
    } else {
        // Plumber is hit by an enemy
        loseLife(); // Custom function to handle life loss
    }
}
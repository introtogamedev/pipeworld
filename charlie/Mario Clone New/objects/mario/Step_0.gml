#macro FPS 60
#macro MS 1000000

// movement constants
#macro MOVE_WALK_MAX		  2.0 * FPS
#macro MOVE_WALK_ACCELERATION 1.8 * FPS
#macro MOVE_RUN_MAX		      3.8 * FPS
#macro MOVE_RUN_ACCELERATION  3.4 * FPS
#macro MOVE_AIR_ACCELERATION  2.4 * FPS
#macro MOVE_DECELERATION      3.4 * FPS

// jump constants
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


state = game.state;


// add input direction; add left input and right input so that
// if both buttons are pressed, the input direction is 0
var _input_move = 0;
if (keyboard_check(INPUT_LEFT)) {
	_input_move -= 1;
}

if (keyboard_check(INPUT_RIGHT)) {
	_input_move += 1;
}

// get run button input
var _input_run = keyboard_check(INPUT_RUN);

// get jump buttton input
var _input_jump = INPUT_STATE.NONE;
if (keyboard_check_pressed(INPUT_JUMP)) {
	_input_jump = INPUT_STATE.PRESS;
} else if (keyboard_check(INPUT_JUMP)) {
	_input_jump = INPUT_STATE.HOLD;
}

// ------------------
// -- add "forces" --
// ------------------

// in this section, we'll run most of our "game logic". what forces
// and other physical changes we make in response to player input.

// start with 0 forces every frame!
var acceleration_x = 0;
var acceleration_y = 0;
var impulse_y = 0;

// -- move --

// add move acceleration
var _move_acceleration = MOVE_WALK_ACCELERATION;
if (!state.on_ground) {
	_move_acceleration = MOVE_AIR_ACCELERATION;
} else if (_input_run) {
	_move_acceleration = MOVE_RUN_ACCELERATION;
}

acceleration_x += _move_acceleration * _input_move;

// -- jump --

// add jump acceleration
var jump = false;

// check if we've held the same jump
var _jump_held = state.jump_held;
if (_input_jump != INPUT_STATE.HOLD) {
	_jump_held = false;
}

// if jump was just pressed on the ground, add impulse, else make gravity floaty
if (_input_jump == INPUT_STATE.PRESS && state.on_ground) {
	impulse_y -= JUMP_IMPULSE;
	jump = true;
	audio_play_sound(hm, 0, false);
} else if (_jump_held && state.velocity_y < 0) {
	acceleration_y += JUMP_HOLD_GRAVITY;
}
// otherwise, add full gravity
else {
	acceleration_y += JUMP_GRAVITY;
}

// if we start a new jump, begin holding
if (jump) {
	_jump_held = true;
}

// get fractional delta time
var _dt = delta_time / MS;

// integrate acceleration & impulse into velocity
state.velocity_x += acceleration_x * _dt;
state.velocity_y += acceleration_y * _dt + impulse_y;

// break down velocity into speed and direction
var velocity_x_magnitude = abs(state.velocity_x);
var velocity_x_direction = sign(state.velocity_x);

// add deceleration if there is no player input
if (_input_move == 0) {
	velocity_x_magnitude -= MOVE_DECELERATION * _dt;
}

// update running state, start when we exceed walk speed
var _running = state.running;
if (_input_run && velocity_x_magnitude >= MOVE_WALK_MAX) {
	_running = true;
}

// and stop when we fall beneath it
if (!_input_run && velocity_x_magnitude <= MOVE_WALK_MAX) {
	_running = false;
}

// apply min / max speeds
var maximum_x_velocity = 420;
if (state.on_ground) {
	maximum_x_velocity = _running ? MOVE_RUN_MAX : MOVE_WALK_MAX;
}

velocity_x_magnitude = clamp(velocity_x_magnitude, 0,  maximum_x_velocity);

// reconstitute velocity from magnitude and direction
state.velocity_x = velocity_x_magnitude * velocity_x_direction;

//collision functions

var x0 = state.position_x - sprite_width/2;
var x1 = state.position_x + sprite_width/2;
var y0 = state.position_y;
var y1 = state.position_y + sprite_height;


// integrate velocity into position
// p1 = p0 + v * t
state.position_x += state.velocity_x * _dt;
state.position_y += state.velocity_y * _dt;

// ------------------
// -- update state --
// ------------------

// update any plumber state that may have changed and that wasn't set
// during integration

// increment frame forever
state.frame_index += 1;

// track if we're running
state.running = _running;

// track if we're still holding our jump
state.jump_held = _jump_held;

// if there is any move input, face that direction
if (_input_move != 0 && state.on_ground) {
	state.orientation = _input_move;
}

// when the jump event fires, start the animation
if (jump) {
	state.jumping_animation = true;
}

// capture the input state
state.input_move = _input_move;

if (_input_move != 0 && _input_move != velocity_x_direction){
	state.skidding = true;
} else {
	state.skidding = false;
}
// ---------------
// -- constants --
// ---------------

// the number of frames per second
#macro FPS 60

// the number of microseconds in a second
#macro MS 1000000

// -- move tuning --
#macro MOVE_WALK_ACCELERATION 1.8 * FPS
#macro MOVE_RUN_ACCELERATION  4.2 * FPS
#macro MOVE_DECELERATION      1.2 * FPS

// -- jump tuning --
#macro JUMP_IMPULSE 4  * FPS * FPS
#macro JUMP_GRAVITY 16 * FPS

// -- input --
#macro INPUT_LEFT  ord("A")
#macro INPUT_RIGHT ord("D")
#macro INPUT_RUN   vk_shift
#macro INPUT_JUMP  vk_space

// -- i/state
enum INPUT_STATE {
	NONE  = 0,
	PRESS = 1,
	HOLD  = 2
}

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
var _ax = 0;
var _ay = 0;

// add move acceleration
var _move_acceleration = MOVE_WALK_ACCELERATION;
if (_input_run) {
	_move_acceleration = MOVE_RUN_ACCELERATION;
}

_ax += _move_acceleration * _input_move;

// add gravity
_ay += JUMP_GRAVITY;

// if jump just pressed on ground, apply impulse
if ( _input_jump == INPUT_STATE.PRESS && is_on_ground) {
	_ay -= JUMP_IMPULSE;
}
// if no jump input, apply gravity
else {
	_ay += JUMP_GRAVITY;
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
// p1 = p0 + v * t
px += vx * _dt;
py += vy * _dt;

// ---------------
// -- collision --
// ---------------

// stop the character from moving through objects that it shouldn't,
// such as the level boundary

// our adjusted collision point
var _px_collision = px;
var _py_collision = py;

// by default, we're not on the ground
var _is_on_ground = false;

// get the bounding box
var _x0 = px;
var _x1 = _x0 + sprite_width;
var _y0 = py;
var _y1 = _y0 + sprite_height;

// if we collide with the level boundary, stop the character
_px_collision = clamp(_px_collision, 0, room_width - sprite_width);

// check for a ground collision at our feet
if (
	level_collision(_x0, _y1) > TILES_NONE ||
	level_collision(_x1, _y1) > TILES_NONE
) {
	// then move the player to the top of the tile
	_py_collision -= py % 16;

	// and track that we're on ground
	_is_on_ground = true;
}

// if we collided on the x-axis, stop velocity
if (px != _px_collision) {
	px = _px_collision;
	vx = 0;
}

// if we collided on the y-axis, stop velocity
if (py != _py_collision) {
	py = _py_collision;
	vy = 0;
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
if (_input_move != 0) {
	look_dir = _input_move;
}

// update ground flag
is_on_ground = _is_on_ground;
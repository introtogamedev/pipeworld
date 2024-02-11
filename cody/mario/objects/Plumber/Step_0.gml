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

// -- jump turning --
#macro JUMP_GRAVITY 16 * FPS

// -- input --
#macro INPUT_LEFT  ord("A")
#macro INPUT_RIGHT ord("D")
#macro INPUT_RUN   vk_shift
#macro INPUT_JUMP vk_space // Define this at the top with your other INPUT macros

// -- jump tuning --
#macro JUMP_FORCE -4.5 * FPS
#macro GROUND_CHECK_OFFSET 4


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

var _input_jump = keyboard_check_pressed(INPUT_JUMP);

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

// if we collide with the level boundary, stop the character
var _px_collision = clamp(px, 0, room_width - sprite_width);
if (px != _px_collision) {
	px = _px_collision;
	vx = 0;
}

// check for ground collision
var _py_collision = py;

// get the bottom of the character
var _y1 = py + sprite_height;

// if it is colliding with a tile
if (level_collision(px, _y1) == TILES_BRICK) {
	// then move the player to the top of the tile
	_py_collision -= py % 16;
}

// if we hit ground, move to the top of the block
if (py != _py_collision) {
	py = _py_collision;
	vy = 0;
	if (_input_jump) {
		vy = JUMP_FORCE;
	}
} else {
	show_debug_message("falling {0}", frame_index);	
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



// Adjust the collision detection for walls and blocks
// Assuming level_collision takes coordinates and returns if there's a solid object
var _left_collision = level_collision(px - 1, py);
var _right_collision = level_collision(px + sprite_width + 1, py);
var _up_collision = level_collision(px, py - 1);
var _down_collision = level_collision(px, py + sprite_height + 1);

// React to collisions by adjusting position and velocity
if (_left_collision && vx < 0) {
    vx = 0;
    px = round(px); // Adjust to not overlap the wall
}

if (_right_collision && vx > 0) {
    vx = 0;
    px = round(px); // Adjust to not overlap the wall
}

if (_up_collision && vy < 0) {
    vy = 0;
    py = round(py); // Adjust to not overlap the ceiling
}

if (_down_collision && vy > 0) {
    vy = 0;
    py = round(py); // Adjust to not overlap the ground
}

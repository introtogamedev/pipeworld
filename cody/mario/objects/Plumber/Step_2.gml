// ---------------
// -- collision --
// ---------------

// stop the character from moving through objects that it shouldn't,
// such as the level boundary

// our adjusted collision point
var _px_collision = state.px;
var _py_collision = state.py;

// by default, we're not on the ground
var _is_on_ground = false;

// get the bounding box
var _x0 = state.px;
var _x1 = _x0 + sprite_width;
var _y0 = state.py;
var _y1 = _y0 + sprite_height;

// -----------
// -- walls --
// -----------

// if we collide with the level boundary, stop the character
_px_collision = clamp(_px_collision, 0, room_width - sprite_width);

// Check for wall collisions on both sides
var left_collision = level_collision(_x0 - 1, state.py);
var right_collision = level_collision(_x1 + 1, state.py);

// Handle wall collisions by stopping horizontal movement
if (left_collision > TILES_NONE || right_collision > TILES_NONE) {
    state.vx = 0; // Stop horizontal movement if there's a wall
}

// ------------
// -- ground --
// ------------

// check for a ground collision at our feet
if (
	level_collision(_x0, _y1) > TILES_NONE ||
	level_collision(_x1, _y1) > TILES_NONE
) {
	// then move the player to the top of the tile
	_py_collision -= state.py % 16 - 1;

	// and track that we're on ground
	_is_on_ground = true;
}

// ------------------
// -- update state --
// ------------------

// update any plumber state that may have changed and that wasn't set
// during collision

// if we collided on the x-axis, stop velocity
if (state.px != _px_collision) {
	state.px = _px_collision;
	state.vx = 0;
}

// if we collided on the y-axis, stop velocity
if (state.py != _py_collision) {
	state.py = _py_collision;
	state.vy = 0;
}

// update ground flag
state.is_on_ground = _is_on_ground;
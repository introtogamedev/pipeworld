// -----------
// -- debug --
// -----------

// if we're paused, do nothing
if (game.is_paused()) {
	return;
}

// ~*~*~*~*~*~*~*~
// ~* collision *~
// ~*~*~*~*~*~*~*~

// stop the character from moving through objects that it shouldn't,
// such as the level boundary

// our adjusted collision point
var _px_collision = state.px;
var _py_collision = state.py;
var _vy_collision = state.vy;

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

// ----------
// -- head --
// ----------

// if we're moving up
if (state.vy < 0) {
	// check for a head collision at our head
	if (level_collision(_x0 + 8, _y0) > TILES_NONE) {
		// then cancel any upwards velocity
		_vy_collision = 0;
	}
}

// ------------
// -- ground --
// ------------

// if we're not moving up
if (state.vy >= 0) {
	// check for a ground collision at our feet
	if (
		level_collision(_x0 + 2, _y1) > TILES_NONE ||
		level_collision(_x1 - 2, _y1) > TILES_NONE
	) {
		// then move the player to the top of the tile
		_py_collision -= state.py % 16 - 1;

		// and track that we're on ground
		_is_on_ground = true;
	}
}

// ----------
// -- side --
// ----------

// check for a left-side collision
if (level_collision(_x0, _y0 + 8) > TILES_NONE) {
	// then move the player to the right of the tile
	_px_collision += 16 - state.px % 16;
}

// check for a right-side collision
if (level_collision(_x1, _y0 + 8) > TILES_NONE) {
	// then move the player to the left of the tile
	_px_collision -= state.px % 16;
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


// if we changed our speed on the y-axis, update it
if (state.vy != _vy_collision) {
	state.vy = _vy_collision;
}

// if we collided on the y-axis, stop velocity
if (state.py != _py_collision) {
	state.py = _py_collision;
	state.vy = 0;
}

// update ground flag
state.is_on_ground = _is_on_ground;

// ~*~*~*~*~*~*~*~
// ~* animation *~
// ~*~*~*~*~*~*~*~

// update any physical state we need to figure out which image
// in the strip to show

// once we land, end the jump animation
if (state.anim_is_jumping && state.is_on_ground) {
	state.anim_is_jumping = false;
}

// -------------
// -- animate --
// -------------

// update the current animation state to show the correct image
// in the strip

var _anim_image_index = state.anim_image_index;
var _anim_move_frame = state.anim_move_frame;

// if jumping, switch to jump
if (state.anim_is_jumping) {
	_anim_image_index = JUMP_ANIM_START;
}
// if moving, switch to move animation
else if (state.is_on_ground && (state.input_move != 0 || state.vx != 0)) {
	_anim_move_frame = (_anim_move_frame + MOVE_ANIM_SPEED) % MOVE_ANIM_LENGTH;
	_anim_image_index = MOVE_ANIM_START + floor(_anim_move_frame);
}
// if no input, switch to standing
else if (state.vx == 0) {
	_anim_image_index = 0;
}

state.anim_image_index = _anim_image_index;
state.anim_move_frame = _anim_move_frame;
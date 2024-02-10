// ---------------
// -- collision --
// ---------------

// stop the character from moving through objects that it shouldn't,
// such as the level boundary

var _px_collision = state.px;
var _py_collision = state.py;

var _is_on_ground = false

var _x0 = state.px;
var _x1 = _x0 + sprite_width;
var _y0 = state.py;
var _y1 = _y0 + sprite_height;

// if we collide with the level boundary, stop the character
_px_collision = clamp(state.px, 0, room_width - sprite_width);

// check for ground collision
if(
	level_collision(_x0, _y1) > TILES_NONE ||
	level_collision(_x1, _y1) > TILES_NONE
){
	//move the player to the top of the tile
	_py_collision -= py % 16 - 1;
	// we are on ground
	_is_on_ground = true;
}
// ------------------
// -- update state --
// ------------------

// x-axis, stop velocity
if (state.px != _px_collision) {
	state.px = _px_collision;
	state.vx = 0;
}

// y-axis, stop velocity
if (state.py != _py_collision) {
	state.py = _py_collision;
	state.vy = 0;
}

state.is_on_ground = _is_on_ground;

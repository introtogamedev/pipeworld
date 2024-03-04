// -----------
// -- debug --
// -----------
if (game.is_paused()) {
	return;
}

// ~*~*~*~*~*~*~*~
// ~* collision *~
// ~*~*~*~*~*~*~*~
var _px_collision = state.px;
var _py_collision = state.py;
var _vy_collision = state.vy;

var _is_on_ground = false;

// get the bounding box
var _x0 = state.px;
var _x1 = _x0 + sprite_width;
var _y0 = state.py;
var _y1 = _y0 + sprite_height;

// -----------
// -- walls --
// -----------
_px_collision = clamp(_px_collision, 0, room_width - sprite_width);

// ----------
// -- head --
// ----------
if (state.vy < 0) {
	if (level_collision(_x0 + 8, _y0) > TILES_NONE) {
		_vy_collision = 0;
	}
}

// ------------
// -- ground --
// ------------
if (state.vy >= 0) {
	if (
		level_collision(_x0 + 2, _y1) > TILES_NONE ||
		level_collision(_x1 - 2, _y1) > TILES_NONE
	) {
		_py_collision -= state.py % 16 - 1;

		_is_on_ground = true;
	}
}

// ----------
// -- side --
// ----------
if (level_collision(_x0, _y0 + 8) > TILES_NONE) {
	_px_collision += 16 - state.px % 16;
}

if (level_collision(_x1, _y0 + 8) > TILES_NONE) {
	_px_collision -= state.px % 16;
}


// ------------------
// -- update state --
// ------------------
if (state.px != _px_collision) {
	state.px = _px_collision;
	state.vx = 0;
}

if (state.vy != _vy_collision) {
	state.vy = _vy_collision;
}

if (state.py != _py_collision) {
	state.py = _py_collision;
	state.vy = 0;
}

state.is_on_ground = _is_on_ground;

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
/*
var _center_ground_check = level_collision(state.px + sprite_width / 2, _y1) > TILES_NONE;
if (!_center_ground_check && (_is_on_ground || state.vy >= 0)) {
    _is_on_ground = false;
}
*/

// ----------
// -- side --
// ----------
if (level_collision(_x0, _y0 + 8) > TILES_NONE) {
	_px_collision += 16 - state.px % 16;
}

if (level_collision(_x1, _y0 + 8) > TILES_NONE) {
	_px_collision -= state.px % 16;
}

/*
var _vx_dir = sign(state.vx);
if (level_collision(_px_collision, _py_collision) > TILES_NONE) {
    // TODO: an additional buffer needed
    if (_vx_dir != 0) {
        _px_collision += _vx_dir * 1;
    }
    if (_vy_collision > 0) {
        _py_collision -= 1;
    }
}
*/

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

// ~*~*~*~*~*~*~*~
// ~* animation *~
// ~*~*~*~*~*~*~*~
if (state.anim_is_jumping && state.is_on_ground) {
	state.anim_is_jumping = false;
}

// -------------
// -- animate --
// -------------
var _anim_image_index = state.anim_image_index;
var _anim_move_frame = state.anim_move_frame;

if (state.anim_is_jumping) {
	_anim_image_index = JUMP_ANIM_START;
}
else if (state.is_on_ground && (state.input_move != 0 || state.vx != 0)) {
	_anim_move_frame = (_anim_move_frame + MOVE_ANIM_SPEED) % MOVE_ANIM_LENGTH;
	_anim_image_index = MOVE_ANIM_START + floor(_anim_move_frame);
}
else if (state.vx == 0) {
	_anim_image_index = 0;
}

state.anim_image_index = _anim_image_index;
state.anim_move_frame = _anim_move_frame;

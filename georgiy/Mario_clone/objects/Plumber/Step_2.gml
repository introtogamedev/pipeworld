var _px_collision = state.px;
var _py_collision = state.py;

var _is_on_ground = false;

var x2 = x + sprite_width;
var y2 = y + sprite_height;

var _x0 = state.px;
var _x1 = _x0 + sprite_width;
var _y0 = state.py;
var _y1 = _y0 + sprite_height;

_px_collision = clamp(_px_collision, 0, room_width - sprite_width);
if (
	level_collision(_x0, _y1) > TILES_NONE ||
	level_collision(_x1, _y1) > TILES_NONE
) {
	_py_collision -= state.py % 16 - 1;
	_is_on_ground = true;
}


if (
    level_collision(_x0, _y0) > TILES_NONE ||
    level_collision(_x1, _y0) > TILES_NONE
) {
	_py_collision += state.py % 16 + 1;
}

if (
    level_collision(_x1, _y0) > TILES_NONE &&
    level_collision(_x1, _y1) > TILES_NONE
) {
	_px_collision -= state.px % 16 + 1;
}

if (
    level_collision(_x0, _y0) > TILES_NONE &&
    level_collision(_x0, _y1) > TILES_NONE
) {
	_px_collision += state.px % 16 - 1;
}


if (state.px != _px_collision) {
	state.px = _px_collision;
	state.vx = 0;
}

if (state.py != _py_collision) {
	state.py = _py_collision;
	state.vy = 0;
}
/*
if (!level_collision(floor(x+3),floor(y+3)) || !level_collision(floor(x2-4), floor(y+3)))
{
    y = y + 2;
    state.vy = 0;
    state.py = floor(y);
}

//From Left
if (!level_collision(floor(x2-2),floor(y+3)) || !level_collision(floor(x2-2), floor(y2-3)))
{
    x = x - state.vx;
    state.px = floor(x);
}

//From Right
if (!level_collision(floor(x+1),floor(y+3)) || !level_collision(floor(x+1), floor(y2-3)))
{
    x = x - state.vx;
    state.px = floor(x);
}

//Top Collision
if (level_collision(floor(x+3), floor(y2)) || level_collision(floor(x2-4), floor(y2))) {
    var collisionDepthTop = (y2 - _y0); // Calculate collision depth
    y -= collisionDepthTop;
    state.vy = 0;
    state.py = floor(y);
    _is_on_ground = true;
    state.is_jump_held = false;
} else {
    _is_on_ground = false;
}
*/

state.is_on_ground = _is_on_ground;
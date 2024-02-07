y += state.vy;
//x += vx;

var _px_collision = state.px;
var _py_collision = state.py;

//bounding box
var _x0 = state.px;
var _x1 = _x0 + sprite_width;
var _y0 = state.py;
var _y1 = _y0 + sprite_height;

//bounds player to level
_px_collision = clamp(_px_collision, 0, room_width - sprite_width);

// if we collided on the x-axis, stop velocity
if (state.px != _px_collision)
{
	state.px = _px_collision;
	state.vx = 0;
}

// if we collided on the y-axis, stop velocity
if (state.py != _py_collision)
{
	state.py = _py_collision;
	state.vy = 0;
}
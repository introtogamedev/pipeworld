y += state.vy;
x += state.vx;

var _px_collision = state.px;
var _py_collision = state.py;
var _vy_collision = state.vy;

//bounding box
var _x0 = state.px;
var _x1 = _x0 + sprite_width;
var _y0 = state.py;
var _y1 = _y0 + sprite_height;

//ROOM BOUNDS
_px_collision = clamp(_px_collision, 0, room_width - sprite_width);

//head
if (state.vy < 0)
{
	//kinda pushes it out of block
	if (level_collision(_x0 + 4, _y0) > TILES_NONE)
	{
		_vy_collision = 0;
	}
	if (level_collision(_x0 + 12, _y0) > TILES_NONE)
	{
		_vy_collision = 0;
	}
}

//right collision
if (level_collision(_x0, _y0 + 8) > TILES_NONE)
{
	_px_collision += 15 - state.px % 16;
}

//left collision
if (level_collision(_x1, _y0 + 8) > TILES_NONE)
{
	_px_collision -= state.px % 16 - 3;
}



//collide on x-axis
if (state.px != _px_collision)
{
	state.px = _px_collision;
	state.vx = 0;
}
//collide on y-axis
if (state.py != _py_collision)
{
	state.py = _py_collision;
	state.vy = 0;
}
//update y speed
if (state.vy != _vy_collision)
{
	state.vy = _vy_collision;
}

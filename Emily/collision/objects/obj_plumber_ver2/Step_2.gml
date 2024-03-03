if (game.debug_is_paused)
{
	return;
}


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

//top collision
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
if (level_collision(_x0 + 1, _y0 + 8) > TILES_NONE)
{
	_px_collision += 16 - state.px % 16;
}

//left collision
if (level_collision(_x1 - 3, _y0 + 8) > TILES_NONE)
{
	_px_collision -= state.px % 16 - 2;
}

//bottom collision
if (state.vy >= 0)
{
	if (level_collision(_x0 + 2, _y1) > TILES_NONE ||
		level_collision(_x1 - 2, _y1) > TILES_NONE)
	{
		_py_collision -= state.py % 16 - 1;
		state.is_on_ground = true;
		falling = false;
		on_floor = true;
		//jumping = true;
	}
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
//reached end of screen
var _px_min = 1;
var _px_max = room_width - sprite_width - 1;
var _px_collision = clamp(state.px, _px_min, _px_max);

if (state.px != _px_collision)
{
	state.px = _px_collision;
	state.vx = 0;
	state.wall_kiss = true;
}
else state.wall_kiss = false;

//check for vertical collision
var _py_coll = state.py;

//check for horizontal collision
var _px_coll = state.px;

//offsets
var _x_offset = 1;
var _y_offset = 4;

//get bounding box
var _x0 = state.px;					//left
var _x1 = state.px + sprite_width	//right
var _y0 = state.py;					//top
var _y1 = state.py + sprite_height;	//bottom

//ground collision
if (
	scr_collision(_x0 + _x_offset, _y1) == false ||
	scr_collision(_x1 - _x_offset, _y1) == false )
{
	_py_coll = state.py - state.py % 16;	
	state.vy = 0;
	
	state.on_floor = true;
}

//ceiling collision
else if (
	scr_collision(_x0 + _x_offset, _y0) == false ||
	scr_collision(_x1 - _x_offset, _y0) == false )
{
	_py_coll = (state.py + sprite_height) - (state.py + sprite_height) % 16;	
	state.vy = 0;
	state.jumping = false;
}

//left wall
if (
	scr_collision(_x0, _y0 + _y_offset) == false ||
	scr_collision(_x0, _y1 - _y_offset) == false )
{
	_px_coll = (state.px + sprite_width) - (state.px + sprite_width) % 16;
	state.vx = 0;
	
	if (state.move) state.wall_kiss = true;
	else state.wall_kiss = false;
}

//right wall
else if (
	scr_collision(_x1, _y0 + _y_offset) == false ||
	scr_collision(_x1, _y1 - _y_offset) == false )
{
	_px_coll = state.px - state.px % 16;	
	state.vx = 0;
	
	if (state.move) state.wall_kiss = true;
	else state.wall_kiss = false;
}

if (state.py != _py_coll)
{
	state.py = _py_coll
	state.vy = 0;
}

if (state.px != _px_coll)
{
	state.px = _px_coll;
	state.vx = 0;
}


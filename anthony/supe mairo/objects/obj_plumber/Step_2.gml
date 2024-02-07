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

//check for ground collision
var _py_collision = state.py;

//get bounding box
var _x0 = state.px;					//left
var _x1 = state.px + sprite_width	//right
var _y0 = state.py;					//top
var _y1 = state.py + sprite_height;	//bottom

//ground collision
if (
	scr_collision(_x0, _y1) == false ||
	scr_collision(_x1, _y1) == false )
{
	_py_collision = state.py - state.py % 16;	
	state.vy = 0;
	
	state.on_floor = true;
}


//wall collision
if (scr_collision(state.px + sprite_width + 1, state.py) == false
	|| scr_collision(state.px - 1, state.py) == false)
{	
	while (scr_collision(state.px + sprite_width + 1, state.py) == false
	|| scr_collision(state.px - 1, _y0) == false)
	{	
		if (state.vx < 0) //left
		{
			state.px += 0.1;
		}
	
		else if (state.vx > 0) //right
		{
			state.px -= 0.1;
		}
		else break;
	}
	state.vx = 0;
	state.wall_kiss = true;
}
else state.wall_kiss = false;


//ceiling collision
if (scr_collision(_x0, state.py) == false
	|| scr_collision(_x1, state.py) == false)
{
	while (scr_collision(_x0, state.py) == false
	|| scr_collision(_x1, state.py) == false)
	{
		state.py += 1;
	}
	state.vy = 0;
	state.jumping = false;
}


if (state.py != _py_collision)
{
	state.py = _py_collision
	state.vy = 0;
}


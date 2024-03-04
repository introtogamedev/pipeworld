/*
// - - - - - - - - -
// - - collisions - - 
// - - - - - - - - -
//stop character from moving through objects that it shouldn't
//including level boundary


//check for collisions
//set variables to current position
var _py_collision = state.py;
var _px_collision = state.px;

//by default, we're not on the ground
var _is_on_ground = false;


//get the bounding box
var _x0 = state.px; //left
var _x1 = state.px +sprite_width; //right
var _y0 = state.py; //top
var _y1 = state.py + sprite_height; //bottom


//if we collide w/ lvl boundary, stop plumber
_px_collision = clamp(_px_collision, 0, room_width - sprite_width);
//var _py_rm_collision = clamp(py, room_height + 64, 0);

//check underneath us for a ground collision
if (
	level_collision(_x0, _y1) ||
	level_collision(_x1, _y1)
){
	//and if there is then move the player to the top of the tile
	_py_collision -= state.py % 16;
	_is_on_ground = true;
}

if (level_collision(_x0, _y0) ||
	level_collision(_x1, _y0))
{
	_py_collision += state.py % 16;
	//_is_on_ground = false;
}
	

//if we left the room or hit the ground, fix position and set velocity to 0
if (state.px != _px_collision ){
	state.px = _px_collision;
	state.vx = 0;
}


//if we hit the ground, move to the top of the block
if (state.py != _py_collision){
	state.py = _py_collision;
	state.vy = 0;
}



//update state
//if there is move input, face that direction

state.is_on_ground = _is_on_ground;

#endregion




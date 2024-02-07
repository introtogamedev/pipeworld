
#macro OFFSET 4

// - - - - - - - - -
// - - collisions - - 
// - - - - - - - - -
//stop character from moving through objects that it shouldn't
//including level boundary


//check for collisions
//set variables to current position
var _py_collision = state.py;
var _px_collision = state.px;
var _falling_from_collision = false;

//by default, we're not on the ground
var _is_on_ground = false;
var _is_jumping = state.is_jumping


//get the bounding box
var _x0 = state.px; //left
var _x1 = state.px +sprite_width; //right
var _y0 = state.py; //top
var _y1 = state.py + sprite_height; //bottom


//if we collide w/ lvl boundary, stop plumber
_px_collision = clamp(_px_collision, 0, room_width - sprite_width);
//var _py_rm_collision = clamp(py, room_height + 64, 0);


//block on plumber's right
if (level_collision(_x1, _y0 + 1))
{
	_px_collision -= state.px % 16;
	show_debug_message("hey i hit smth");
}

//block on plumber's left
if (level_collision(_x0, state.py))
{
	_px_collision += 16 - (state.px % 16);
}


//check underneath us for a ground collision
if ((
	level_collision(_x0 + OFFSET, _y1) ||
	level_collision(_x1 - OFFSET, _y1))
	&& !(state.vy < 0)
){
	//and if there is then move the player to the top of the tile
	_py_collision -= state.py % 16;
	_is_on_ground = true;
}

//is there a block above plumber????
if ((level_collision(_x0 + OFFSET, _y0) ||
	level_collision(_x1 - OFFSET, _y0)))
	&& !_is_on_ground
{
	//the GET OUT OF THE BLOCK
	_py_collision += state.py % 16;
	//oh hey we're falling
	_falling_from_collision = true;
	// if we've done a side collision FOR WHATEVER REASON
	if (_px_collision != state.px) {
		//STOP DOING THE SIDE COLLISION 
		_px_collision = state.px;
	}
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
state.falling_from_collision = _falling_from_collision;

#endregion




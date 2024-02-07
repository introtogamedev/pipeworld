

var _py_collision = state.py;
var _px_collision = state.px;

var _x0 = state.px;
var _x1 = _x0 + sprite_width;
var _y0 = state.py;
var _y1 = _y0 + sprite_height;

//collision

var _is_on_ground = false;

//level boundary
_px_collision = clamp(_px_collision, 0, room_width - sprite_width);

if (level_collision(state.px, _y1) = TILES_BRICK) or
	level_collision(state.px + 16, _y1) = TILES_BRICK{
		// find tile position
		_py_collision -= state.py % 16;
	// and track that we're on ground
		_is_on_ground = true;
		show_debug_message("Ground");
}

//up
if ((level_collision(state.px, state.py) = TILES_BRICK or 
	level_collision(state.px+16, state.py) = TILES_BRICK)) {
		//_py_collision_head += ((py % 16)+2);
		_py_collision += (16 - (state.py%16));
		//py = _py_collision_head;
		show_debug_message("Head");
}

//left
if ((level_collision(state.px, state.py) = TILES_BRICK or 
	level_collision(state.px, state.py+16) = TILES_BRICK) and state.vx < 0) {
		//_py_collision_head += ((py % 16)+2);
		_px_collision += (16 - (state.px%16));
		//py = _py_collision_head;
		show_debug_message("");
}

/*
if (level_collision(state.px, state.py) = TILES_BRICK or 
	level_collision(state.px + 16, state.py) = TILES_BRICK) {
		//_py_collision_head += ((py % 16)+2);
		_py_collision += (16 - (state.py%16));
		//py = _py_collision_head;
		show_debug_message("Head");
}

*/
// if we collided on the x or y-axis, stop velocity
if (state.px != _px_collision) {
	state.px = _px_collision;
	state.vx = 0;
}


if (state.py != _py_collision) {
	state.py = _py_collision;
	state.vy = 0;
}

//state update
state.on_ground = _is_on_ground;
state.jumping = !_is_on_ground;

//left col
/*
if (level_collision(px, py) = TILES_BRICK or level_collision(px, py+16)) {
		//_py_collision_head += ((py % 16)+2);
		vx = 0;
		px += (16 - (px%16));

		//py = _py_collision_head;
		
		show_debug_message("Head");
}

//right col
if (level_collision(px + 16, py) = TILES_BRICK) or level_collision(px + 16, py+16) = TILES_BRICK{
		vx = 0;
		px -= px%16;
		
		show_debug_message("Ground");
	// then move the player to the top of the tile
}
*/




// if we hit ground, move to the top of the block

// stop the character from moving through objects that it shouldn't,
// such as the level boundary

// our adjusted collision point
var _px_collision = state.position_x;
var _py_collision = state.position_y;

// by default, we're not on the ground
var _on_ground = false;

// get the bounding box
var _x0 = state.position_x - sprite_width/2;
var _x1 = _x0 + sprite_width;
var _x3 = _x0 + 3;
var _x4 = _x1 - 3;
var _y0 = state.position_y;
var _y1 = _y0 + sprite_height;
var _y3 = state.position_y + 5;
var _y4 = _y1 - 5;


// if we collide with the level boundary, stop the character
_px_collision = clamp(_px_collision, sprite_width/2, room_width - sprite_width/2);

// ------------
// -- ground --
// ------------
var stuck = false;

// check for a ceiling collision
if (
	(level_collision(_x0, _y0) > TILES_NONE && level_collision(_x3, _y0) > TILES_NONE) ||
	(level_collision(_x1, _y0) > TILES_NONE&& level_collision(_x4, _y0) > TILES_NONE)
) {
	// move the player to the botton of the tile
	_py_collision += 16 - (state.position_y % 16);
	state.velocity_y = 0;
}

// check for being on edge of platform
if (
	(level_collision(_x0, _y1) > TILES_NONE && level_collision(_x3, _y1) > TILES_NONE) ||
	(level_collision(_x1, _y1) > TILES_NONE && level_collision(_x4, _y1) > TILES_NONE)
) {
	// then move the player to the top of the tile
	_py_collision -= state.position_y % 16;

	// and track that we're on ground
	_on_ground = true;
	state.velocity_y = 0;
}

// if we collided on the y-axis, stop velocity
if (state.position_y != _py_collision) {
	state.position_y = _py_collision;
	state.velocity_y = 0;
}


_y0 = state.position_y;
_y1 = _y0 + sprite_height;
_y3 = state.position_y + 5;
_y4 = _y1 - 5;


if (
	(level_collision(_x0, _y1) > TILES_NONE && !level_collision(_x3, _y1) > TILES_NONE)
) {
	if (state.velocity_x == 0){
		state.velocity_x = 6;
	}
	show_debug_message("right CLIP");
}else if /* collides on the left*/( (!stuck) &&
	((level_collision(_x0, _y0) > TILES_NONE && level_collision(_x0, _y3) > TILES_NONE) ||
	(level_collision(_x0, _y1) > TILES_NONE && level_collision(_x0, _y4) > TILES_NONE))
) {
	_px_collision += 16 - (state.position_x - sprite_width/2) % 16 + 1;
	show_debug_message("push to right");
} 

if /* clip towards left */(
	(level_collision(_x1, _y1) > TILES_NONE && !level_collision(_x4, _y1) > TILES_NONE)
) {
	if (state.velocity_x == 0){
		state.velocity_x = -6;
	}
	show_debug_message("left clip");
}// check for collision withright wall
else if ((!stuck) &&
	((level_collision(_x1, _y0) > TILES_NONE && level_collision(_x1, _y3) > TILES_NONE) ||
	(level_collision(_x1, _y1) > TILES_NONE && level_collision(_x1, _y4) > TILES_NONE))
) {
	_px_collision -= (state.position_x - sprite_width/2) % 16 + 1;
	show_debug_message("push to left");
}


// if we collided on the x-axis, stop velocity
if (state.position_x != _px_collision) {
	state.position_x = _px_collision;
	state.velocity_x = 0;
}


// update ground flag
state.on_ground = _on_ground;

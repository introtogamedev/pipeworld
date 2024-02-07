// the first index in the strip for the move animation
#macro MOVE_ANIM_START  1

// the number of frames in the strip for the move animation
#macro MOVE_ANIM_LENGTH 3

// the frames per second in the move animation
#macro MOVE_ANIM_SPEED 1 / 7

#macro JUMP_ANIM_INDEX 5

// -------------
// -- animate --
// -------------

// update the current animation state

// if moving, switch to move animation
if (input_move != 0 || vx != 0) {
	move_frame = (move_frame + MOVE_ANIM_SPEED) % MOVE_ANIM_LENGTH;
	image_idx = MOVE_ANIM_START + move_frame;
} 
// if no input, switch to standing
else {
	image_idx = 0;
}

if (vy != 0) {
	image_idx = JUMP_ANIM_INDEX;
}

// ----------
// -- draw --
// ----------

// draw the character given their current state

// make sure the position is always pixel-aligned
var _x = floor(px);
var _y = floor(py);

// face in the move direction
var _xscale = 1;

// if moving left, flip the sprite
if (sign(look_dir) < 0) {
	_x += sprite_width;
	_xscale = -1;
}

// draw the sprite
draw_sprite_ext(
	sprite_index, 
	image_idx, 
	_x,
	_y,
	_xscale, 
	image_yscale, 
	image_angle, 
	image_blend, 
	image_alpha
);
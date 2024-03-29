
// the first index in the strip for the move animation
#macro MOVE_ANIM_START  1
// the number of frames in the strip for the move animation
#macro MOVE_ANIM_LENGTH 3
// the frames per second in the move animation
#macro MOVE_ANIM_SPEED 1 / 7


// make sure the position is always pixel-aligned
var _x = floor(state.px);
var _y = floor(state.py);

// face in the move direction
var _xscale = 1;

// if moving left, flip the sprite
if (sign(state.look_dir) < 0) 
{
	_xscale = -1;
}

// draw the sprite
draw_sprite_ext(
	sprite_index, 
	state.image_idx, 
	_x,
	_y,
	_xscale, 
	image_yscale, 
	image_angle, 
	image_blend, 
	image_alpha
);




















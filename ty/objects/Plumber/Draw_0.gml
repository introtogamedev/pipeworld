// ---------------
// -- constants --
// ---------------

// the first index in the strip of the move animation
#macro MOVE_ANIM_START  1

// the number of frames in the strip for the move animation
#macro MOVE_ANIM_LENGTH 3

// the frames per second in the move animation
#macro MOVE_ANIM_SPEED  1 / 7

// the first index in the strip of the jump animation
#macro JUMP_ANIM_START  5

// ----------
// -- draw --
// ----------

// draw the character given their current state

// make sure the position is always pixel-aligned
var _x = floor(state.px);
var _y = floor(state.py);

// face in the move direction
var _xscale = 1;

// if moving left, flip the sprite
if (sign(state.look_dir) < 0) {
	_x += sprite_width;
	_xscale = -1;
}

// draw the sprite
draw_sprite_ext(
	sprite_index,
	state.anim_image_index,
	_x,
	_y,
	_xscale,
	image_yscale,
	image_angle,
	image_blend,
	image_alpha
);

// draw debug collisions
if (!state.is_on_ground) {
	draw_set_color(c_white);
} else if (!state.is_running) {
	draw_set_color(abs(state.vx) > MOVE_WALK_MAX ? c_black : c_red);
} else {
	draw_set_color(c_lime);
}

draw_rectangle(
	_x,
	_y,
	_x + sprite_width * _xscale,
	_y + sprite_height,
	true
);
// ---------------
// -- constants --
// ---------------
#macro MOVE_ANIM_START  1

#macro MOVE_ANIM_LENGTH 3

#macro MOVE_ANIM_SPEED  1 / 7

#macro JUMP_ANIM_START  5

// ----------
// -- draw --
// ----------
var _x = floor(state.px);
var _y = floor(state.py);

var _xscale = 1;

if (sign(state.look_dir) < 0) {
	_x += sprite_width;
	_xscale = -1;
}

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

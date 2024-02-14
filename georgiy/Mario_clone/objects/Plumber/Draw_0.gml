
#macro MOVE_ANIM_START  1
#macro MOVE_ANIM_LENGTH 3
#macro MOVE_ANIM_SPEED  1 / 7
#macro JUMP_ANIM_START  5

if (state.anim_is_jumping && state.is_on_ground) {
	state.anim_is_jumping = false;
}
var _anim_image_index = state.anim_image_index;
var _anim_move_frame = state.anim_move_frame;

if (state.anim_is_jumping) {
	_anim_image_index = JUMP_ANIM_START;
}
else if (state.is_on_ground && (state.input_move != 0 || state.vx != 0)) {
	_anim_move_frame = (_anim_move_frame + MOVE_ANIM_SPEED) % MOVE_ANIM_LENGTH;
	_anim_image_index = MOVE_ANIM_START + floor(_anim_move_frame);
}
else if (state.vx == 0) {
	_anim_image_index = 0;
}

state.anim_image_index = _anim_image_index;
state.anim_move_frame = _anim_move_frame;

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
/*
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
); */
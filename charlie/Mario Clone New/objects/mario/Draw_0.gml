// the first index in the strip of the move animation
#macro MOVE_ANIM_START  1

// the skid sprite index
#macro SKID_SPRITE 4

// the number of frames in the strip for the move animation
#macro MOVE_ANIM_LENGTH 3

// the frames per second in the move animation
#macro MOVE_ANIM_SPEED  1 / 7

// the first index in the strip of the jump animation
#macro JUMP_ANIM_START  5


// once we land, end the jump animation
if (state.jumping_animation && state.on_ground) {
	state.jumping_animation = false;
}

// -------------
// -- animate --
// -------------

// update the current animation state to show the correct image
// in the strip

var _anim_image_index = state.animation_index;
var _anim_move_frame = state.movement_frame;

// if jumping, switch to jump
if (state.jumping_animation) {
	_anim_image_index = JUMP_ANIM_START;
}
// if moving, switch to move animation
else if (state.skidding){
	_anim_image_index = SKID_SPRITE;
} else if (state.on_ground && (state.input_move != 0 || state.velocity_x != 0)) {
	_anim_move_frame = (_anim_move_frame + MOVE_ANIM_SPEED) % MOVE_ANIM_LENGTH;
	_anim_image_index = MOVE_ANIM_START + floor(_anim_move_frame);
}
// if no input, switch to standing
else if (state.velocity_x == 0) {
	_anim_image_index = 0;
}

state.animation_index = _anim_image_index;
state.movement_frame = _anim_move_frame;

// draw the character given their current state

// make sure the position is always pixel-aligned
var _x = floor(state.position_x);
var _y = floor(state.position_y);

// face in the move direction
var _xscale = 1;

// if moving left, flip the sprite
if (sign(state.orientation) < 0) {
	_xscale = -1;
}

// draw the sprite
draw_sprite_ext(
	sprite_index,
	state.animation_index,
	_x,
	_y,
	_xscale,
	image_yscale,
	image_angle,
	image_blend,
	image_alpha
);

// draw debug collisions
if (!state.on_ground) {
	draw_set_color(c_white);
} else if (!state.running) {
	draw_set_color(abs(state.velocity_x) > MOVE_WALK_MAX ? c_black : c_red);
} else {
	draw_set_color(c_lime);
}

draw_rectangle(
	_x - sprite_width/2,
	_y,
	_x + sprite_width/2,
	_y + sprite_height,
	true
);
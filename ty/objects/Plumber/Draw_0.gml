// the first index in the strip of the move animation
#macro MOVE_ANIM_START  1

// the number of frames in the strip for the move animation
#macro MOVE_ANIM_LENGTH 3

// the frames per second in the move animation
#macro MOVE_ANIM_SPEED  1 / 7

// the first index in the strip of the jump animation
#macro JUMP_ANIM_START  5

// -----------
// -- state --
// -----------

// update any physical state we need to figure out which image
// in the strip to show

// once we land, end the jump animation
if (anim_is_jumping && is_on_ground) {
	anim_is_jumping = false;
}


// -------------
// -- animate --
// -------------

// update the current animation state to show the correct image
// in the strip

// if jumping, switch to jump
if (anim_is_jumping) {
	anim_image_index = JUMP_ANIM_START;
}
// if moving, switch to move animation
else if (is_on_ground && (input_move != 0 || vx != 0)) {
	anim_move_frame = (anim_move_frame + MOVE_ANIM_SPEED) % MOVE_ANIM_LENGTH;
	anim_image_index = MOVE_ANIM_START + floor(anim_move_frame);
}
// if no input, switch to standing
else if (vx == 0) {
	anim_image_index = 0;
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
	anim_image_index,
	_x,
	_y,
	_xscale,
	image_yscale,
	image_angle,
	image_blend,
	image_alpha
);

// draw debug collisions
if (is_on_ground) {
	draw_set_color(c_red);
} else {
	draw_set_color(c_white);
}

draw_rectangle(
	_x,
	_y,
	_x + sprite_width * _xscale,
	_y + sprite_height,
	true
);

//constants
//the index in the strip for the run animation
#macro MOVE_ANIM_START 1

//number of frames in strip in run animation 
#macro MOVE_ANIM_LENGTH 3

#macro MOVE_ANIM_SPEED 1/7

//------
//--animate
//--------

//updat the current animation state

//if moving, switch to move animation
if ((input_dir != 0) || vx !=0) {

	move_frame = (move_frame + MOVE_ANIM_SPEED) % MOVE_ANIM_LENGTH;
	image_idx = MOVE_ANIM_START + move_frame;
}
//if no input, switch to standing
else if (vx==0) {
	image_idx = 0;
}

//--------
//--draw sprite
//-----


//make sure the position is always pixel-aligned
var _x = floor(px);

//face in teh move direction
var _xscale = 1;

//if moving left, flip the sprite
if (sign (look_dir < 0 )){
	_xscale = -1;
	_x += sprite_width;
}

draw_sprite_ext(
	sprite_index,
	image_idx,
	_x,
	y,
	 _xscale,
	image_yscale,
	image_angle,
	image_blend,
	image_alpha
)

show_debug_message(image_idx);



// make sure you can't change direction while jumping or falling

/*
//constants
//the index in the strip for the run animation
#macro MOVE_ANIM_START 1
#macro JUMP_FRAME 5

//number of frames in strip in run animation 
#macro MOVE_ANIM_LENGTH 3

#macro MOVE_ANIM_SPEED 1/7

//------
//--animate
//--------

//updat the current animation state

//if moving, switch to move animation
if ((state.input_dir != 0) || state.vx !=0) && (state.vy == 0) {

	state.move_frame = (state.move_frame + MOVE_ANIM_SPEED) % MOVE_ANIM_LENGTH;
	state.image_idx = MOVE_ANIM_START + state.move_frame;
}
//if we're jumping, switch to the jump boi
else if (state.vy < 0)
{
	state.image_idx = JUMP_FRAME;
}
//if no input, switch to standing
else if (state.vx == 0) && (state.vy == 0) {
	state.image_idx = 0;
}


//--------
//--draw sprite
//-----


//make sure the position is always pixel-aligned
var _x = floor(state.px);
var _y = floor(state.py); 

//face in teh move direction
var _xscale = 1;

//if moving left, flip the sprite
if (sign (state.look_dir < 0 )){
	_xscale = -1;
	_x += sprite_width;
}

draw_sprite_ext(
	sprite_index,
	state.image_idx,
	_x,
	y,
	 _xscale,
	image_yscale,
	image_angle,
	image_blend,
	image_alpha
)

//debug

if (state.is_on_ground) {draw_set_color(c_white)}
//else if (is_running)
else {draw_set_color(c_lime)}

	draw_rectangle(
	_x,
	_y,
	_x + sprite_width*_xscale,
	y + sprite_height,
	true)


//*/


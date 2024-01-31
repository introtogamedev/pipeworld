//first index
#macro run_animation_start 1
//num frame in strip
#macro run_anim_len 3
#macro run_anim_speed 1/6

// animate
if (_input_dir != 0 || vx != 0){
	move_frame = (move_frame + run_anim_speed) % run_anim_len;
	image_idx = run_animation_start + move_frame;
}
else if (vx == 0) {
	image_idx = 0;
}

//face in move direction
//allligns pos
var _x = floor(px);
var _xscale = 1;
if (sign(look_dir) < 0)
	{ 
		_x += sprite_width;
		_xscale = -1;
	}
draw_sprite_ext( 
	sprite_index,
	image_idx,
	x,
	y,
	_xscale,
	image_yscale,
	image_angle,
	image_blend,
	image_alpha
);

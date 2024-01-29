// face in the move direction
var _x = px;
var _xscale = 1;

// if moving left, flip the sprite
if (sign(look_dir) < 0) {
	_x += sprite_width;
	_xscale = -1;
}

// draw the sprite
draw_sprite_ext(
	sprite_index, 
	image_index, 
	_x, 
	y, 
	_xscale, 
	image_yscale, 
	image_angle, 
	image_blend, 
	image_alpha
);
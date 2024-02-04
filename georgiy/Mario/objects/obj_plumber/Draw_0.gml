/// @description Insert description here
// You can write your code in this editor
var _x = floor(px);
var _y = floor(py);
var _xscale = image_xscale;
if ( sign(vx) < 0 ) {
	_xscale = -image_xscale;
//	x = sprite_width;
}
draw_sprite_ext(sprite_index,
image_index,
_x,
_y,
_xscale,
image_yscale,
image_angle,
image_blend,
image_alpha
);


var _x = floor(state.px);
var _y = floor(state.py);

// face in the move direction
var _xscale = 1;


// draw the sprite
draw_sprite_ext(sprite_index,image_index,_x,_y,_xscale,
	image_yscale,image_angle,image_blend,image_alpha);



//draw_rectangle(_x,_y,_x + sprite_width * _xscale,_y + sprite_height,true);
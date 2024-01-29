var _look = 1;
var _x = floor(px);
var _y = floor(py);

if (vx == 0) sprite_index = spr_stand;
if (move) sprite_index = spr_move;
if (turn) sprite_index = spr_turn;
if (jump_sprite) sprite_index = spr_jump;

image_speed = vx / 180; //sprite animation fps control


//x scale based on where plumber looks
if (left) 
{
	_look = -1;
	_x = x + sprite_width;
}
else if (right) 
{
	_look = 1;
	_x = x
}

draw_sprite_ext(sprite_index,image_index,_x,_y,_look,1,0,c_white,1);


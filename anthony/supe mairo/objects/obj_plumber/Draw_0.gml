var _look = 1;
var _x = floor(state.px);
var _y = floor(state.py);

if (state.vx == 0 && !state.wall_kiss) sprite_index = spr_stand;
if (state.move) sprite_index = spr_move;
if (state.turn) sprite_index = spr_turn;
if (state.jump_sprite) sprite_index = spr_jump;

if (state.wall_kiss) //animation speed fix when walking into walls
{
	//THIS DOESNT WORK????????????
	image_speed = 1; 
}
else 
{
	image_speed = state.vx / 180; //sprite animation fps control
}

//x scale based on where plumber looks
if (state.left) 
{
	_look = -1;
	_x = x + sprite_width;
}
else if (state.right) 
{
	_look = 1;
	_x = x
}

draw_sprite_ext(sprite_index,image_index,_x,_y,_look,1,0,c_white,1);
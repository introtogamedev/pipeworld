// thus number of microsecond in a second
#macro MS 1000000
#macro JUMP_FROCE -3
#macro NORMAL_GRAVITY 5
#macro JUMP_GRAVITY 2

//aceleration constant
#macro MOVE_ACEL 6
#macro MOVE_FRIC 4

max_speed = 3;

var _input_dir = 0;
if(keyboard_check(ord("A"))){
	_input_dir -= 1;
	//image_xscale = -1;
}

if (keyboard_check(ord("D"))){
	_input_dir += 1;
	//image_xscale = 1;
}

if (keyboard_check(vk_shift)){
	max_speed = 5;
	//image_xscale = 1;
}

if (keyboard_check_pressed(vk_space) and not jumping){
	jumping = true;
	vy = JUMP_FROCE;
	
}


var _dt = delta_time / MS;
var _ax = MOVE_ACEL	* _input_dir;
var _ay = NORMAL_GRAVITY;

if (_input_dir = 0 and vx != 0){
	_ax = (-sign(vx) * MOVE_FRIC); //equavilent to ax = dirction * acel
}


if (abs(vx) > max_speed){
	vx = sign(vx) * max_speed
}

if (keyboard_check(vk_space) and vy < 0 and jumping)
{
	_ay = JUMP_GRAVITY;
}

//Movementcode
vx += _ax * _dt;
vy += _ay * _dt;
px += vx;
py += vy;

/*
	var temp = vy;
	while (emp > 0) {
		if (!level_collision(px,py+sign(temp)) {
			py += sign(temp);
			temp -= sign(temp);
			if (abs(temp) < 1){
				break;
		}
	}
	
*/
var _py_collision = py;
var _py_collision_head = py;
var _y1 = py + sprite_height;
/*
if (place_meeting(px, py-1, tilemap) and vy < 0) {
	// then move the player to the top of the tile
	//_py_collision_head += py % 16;
	vy = 0;
	show_debug_message("HeadBump");
}
*/

//down col

if (level_collision(px, _y1) = TILES_BRICK) or level_collision(px + 16, _y1) = TILES_BRICK{
		_py_collision -= py % 16;
		jumping = false;
		py = _py_collision;
		vy = 0;
		show_debug_message("Ground");
	// then move the player to the top of the tile
}

//up col
if (level_collision(px, py) = TILES_BRICK or level_collision(px + 16, py) = TILES_BRICK) {
		//_py_collision_head += ((py % 16)+2);
		vy = 0;
		py += (16 - (py%16));

		//py = _py_collision_head;
		
		show_debug_message("Head");
}

//left col
/*
if (level_collision(px, py) = TILES_BRICK or level_collision(px, py+16)) {
		//_py_collision_head += ((py % 16)+2);
		vx = 0;
		px += (16 - (px%16));

		//py = _py_collision_head;
		
		show_debug_message("Head");
}

//right col
if (level_collision(px + 16, py) = TILES_BRICK) or level_collision(px + 16, py+16) = TILES_BRICK{
		vx = 0;
		px -= px%16;
		
		show_debug_message("Ground");
	// then move the player to the top of the tile
}
*/




// if we hit ground, move to the top of the block
if (py != _py_collision) {
	
	
}else if (py != _py_collision_head) {
	
		
}


frame_index += 1;

//Make sure mario in game
if px > 240{
	px= 240;
}

if px < 0{
	px = 0;
}

input_move = _input_dir;


if (_input_dir != 0) {
	look_dir = _input_dir;
}


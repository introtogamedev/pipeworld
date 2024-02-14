// thus number of microsecond in a second
#macro MS 1000000
#macro JUMP_FROCE -3
#macro NORMAL_GRAVITY 9
#macro JUMP_GRAVITY 3

//aceleration constant
#macro MOVE_ACEL 6
#macro MOVE_FRIC 4
#macro MARIOJUMP maro_jump_sound_effect_1
#macro VINEBOOM vine_boom

state.max_speed = 3;


state = instance_nearest(0,0, Game).state;

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
	state.max_speed = 5;
	//image_xscale = 1;
}

//Jumping if pressed jump and on_ground

var _iy = 0;
if (keyboard_check_pressed(vk_space) and state.on_ground){
	state.jumping = true;
	_iy = JUMP_FROCE;
	audio_play_sound(VINEBOOM, 1, false);
	show_debug_message("JUMP");
	
	
}


var _dt = delta_time / MS;
var _ax = MOVE_ACEL	* _input_dir;
var _ay = NORMAL_GRAVITY;

// friction move
var _vx_mag = abs(state.vx);
var _vx_dir = sign(state.vx);

if (_input_dir = 0){
	_vx_mag -= MOVE_FRIC * _dt;
	_vx_mag = max(_vx_mag, 0);
}

//clamp max speed
state.vx = _vx_mag
state.vx = _vx_mag * _vx_dir;

if (abs(state.vx) > state.max_speed){
	state.vx = sign(state.vx) * state.max_speed
}


//Applie Jump Gravity when pressing space and jumping 
//###### need to implement check if same jump
if (keyboard_check(vk_space) and state.vy < 0 and state.jumping and !state.on_ground)
{
	_ay = JUMP_GRAVITY;
}

//Movementcode Integration
state.vx += _ax * _dt;
state.vy += (_ay * _dt) + _iy;
state.px += state.vx;
state.py += state.vy;

//frame index
state.frame_index += 1;

//Make sure mario in game
if state.px > 240{
	state.px= 240;
}

if state.px < 0{
	state.px = 0;
}


state.input_move = _input_dir;

//look_dir for draw
if (_input_dir != 0) {
	state.look_dir = _input_dir;
}


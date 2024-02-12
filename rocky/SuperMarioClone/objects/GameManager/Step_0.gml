/// @description Insert description here
// You can write your code in this editor
#macro PAUSE ord("O")
#macro FORWARD ord("P")
#macro REWIND ord("I")

if(_temp_frame){
	_temp_frame=false;
	global._pause=true;
}

if(keyboard_check_pressed(ord("R"))){
	global.state.x=32;
	global.state.y=128;
	camera_set_view_pos(obj_mario.camera,0,0);
}

if(keyboard_check_pressed(PAUSE)){
	global._pause=!global._pause;
}
if(keyboard_check_pressed(REWIND)){
	if(!global._pause)
		global._pause=true;
	global.state = variable_clone(ring_pop(obj_mario.ring_buffer),1);
}
else if(keyboard_check_pressed(FORWARD)){
	if(!global._pause)
		global._pause=true;
	_temp_frame=true;
	global._pause=false;
}
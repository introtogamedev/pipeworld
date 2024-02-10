// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function save_state(){
	var file=file_text_open_write("gameinfo.txt");
	//var file=file_text_open_write("D:/gameinfo.txt");
	var state={
		x: obj_mario.x,
		y: obj_mario.y,
		cam_x: camera_get_view_x(obj_mario.camera),
		cam_y: camera_get_view_y(obj_mario.camera)
	}
	var json=json_stringify(state, false);
	file_text_write_string(file,json);
	
	file_text_close(file);
	show_debug_message("file saved");
}
function load_state(){
	var file=file_text_open_read("gameinfo.txt");
	var str=file_text_read_string(file);
	var state=json_parse(str);
	var camera=view_camera[0];
	camera_set_view_pos(camera,state.cam_x,state.cam_y);
	obj_mario.x=state.x;
	obj_mario.y=state.y;
}
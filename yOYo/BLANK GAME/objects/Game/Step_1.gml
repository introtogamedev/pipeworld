/// @description Insert description here
// You can write your code in this editor




/// @description Insert description here
// You can write your code in this editor

step_offstep = 0;

/// @description Insert description here
// You can write your code in this editor
if (keyboard_check_pressed(vk_lcontrol))
{
	show_debug_message("json Write Attempt");
	//json_write(SAVE_STATE_PATH, global.plumberstate);
	
}

if (keyboard_check_pressed(vk_escape) and not is_paused)
{
	is_paused = true;
	show_debug_message("Paused")
	//json_write(SAVE_STATE_PATH, global.plumberstate);
	
}else if (keyboard_check_pressed(vk_escape)){
	is_paused = false;
}

if (keyboard_check_pressed(ord("P")))
{
	step_offstep = 1;
	show_debug_message("Frame Advanced")
}





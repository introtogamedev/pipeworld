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
	save_mario_json();	
}

if (keyboard_check_pressed(vk_rshift))
{
	show_debug_message("json Load Attempt");
	load_mario_json();	
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

if (keyboard_check_pressed(ord("O")))
{
	step_offstep = -1;
}


//only record if no offstep and not paused
if (!is_paused or step_offstep > 0)
{
	ring_push(state_buffer, struct_copy(state));
}

if (is_paused && step_offstep < 0)
{
	ring_pop(state_buffer);
	show_debug_message("Frame Rewind")
	
}

state = ring_head(state_buffer);




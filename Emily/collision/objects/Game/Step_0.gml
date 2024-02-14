#macro INPUT_QUIT vk_escape
#macro INPUT_SAVE 221
#macro INPUT_LOAD 219

// quit game when you press esc
if (keyboard_check_pressed(INPUT_QUIT))
{
	game_end();
}

// save the state when you press "]"
if (keyboard_check_pressed(INPUT_SAVE))
{
	state_saved = struct_copy(state);
}

// load the state when you press "["
if (keyboard_check_pressed(INPUT_LOAD))
{
	state = struct_copy(state_saved);
}
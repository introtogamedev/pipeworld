#macro INPUT_QUIT vk_escape
#macro INPUT_SAVE 221
#macro INPUT_LOAD 219
#macro INPUT_ADVANCE ord("0")

//quit game
if (keyboard_check_pressed(INPUT_QUIT))
{
	game_end();
}

//save the state
if (keyboard_check_pressed(INPUT_SAVE))
{
	state_saved = struct_copy(state);
}

//load the state
if (keyboard_check_pressed(INPUT_LOAD))
{
	state = struct_copy(state_saved);
}

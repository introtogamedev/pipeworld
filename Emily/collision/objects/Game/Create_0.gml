#macro SAVE_STATE_PATH working_directory + "save-state.json"
#macro SAVE_STATE_AUTOLOAD true
#macro STATE_BUFFER_LENGTH 60

state = global.state;

state_buffer = ring_create(STATE_BUFFER_LENGTH);

//current saved state
saved_state = global.state;

//if game is paused
debug_is_paused = false;

debug_step_offset = 0;


if (file_exists(SAVE_STATE_PATH))
{
	var _json = json_read(SAVE_STATE_PATH);

	struct_update(saved_state, _json);

	if (SAVE_STATE_AUTOLOAD)
	{
		state = struct_copy(saved_state);
	}
}
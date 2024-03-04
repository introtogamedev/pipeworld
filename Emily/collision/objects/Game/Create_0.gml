#macro SAVE_STATE_PATH working_directory + "save-state.json"
#macro SAVE_STATE_AUTOLOAD true
#macro STATE_BUFFER_LENGTH 60


//current state
state = struct_copy(global.state);

//save state
state_saved = struct_copy(state);

//state buffer
state_buffer = ring_create(STATE_BUFFER_LENGTH);

//save state
state_saved = struct_copy(state);

debug_is_paused = false;
debug_step_offset = 0;

// if save file exists
if (file_exists(SAVE_STATE_PATH))
{
	//read from disk
	var _json = json_read(SAVE_STATE_PATH);

	//update save state
	struct_update(state_saved, _json);

	//autoload save state
	if (SAVE_STATE_AUTOLOAD)
	{
		state = struct_copy(state_saved);
	}
}
#macro SAVE_STATE_PATH     working_directory + "save-state.json"
#macro SAVE_STATE_AUTOLOAD true


//current state
state = struct_copy(global.state);

// save state
state_saved = struct_copy(state);

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
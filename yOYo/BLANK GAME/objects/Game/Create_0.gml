
//current state

// ---------------
// -- constants --
// ---------------

#macro SAVE_STATE_PATH     working_directory + "save-state.json"
#macro SAVE_STATE_AUTOLOAD true

// -----------
// -- ivars --
// -----------

// the current state
state = struct_copy(global.plumberstate);

// the save state
state_saved = struct_copy(state);

// ----------------
// -- save state --
// ----------------

// if the save file exists
if (file_exists(SAVE_STATE_PATH)) {
	// read it from disk
	var _json = json_read(SAVE_STATE_PATH);

	// and update the save state, if any
	struct_update(state_saved, _json);

	// autoload the save state
	if (SAVE_STATE_AUTOLOAD) {
		state = struct_copy(state_saved);
	}
}
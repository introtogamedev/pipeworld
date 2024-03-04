// ---------------
// -- constants --
// ---------------

// where to store the save file
#macro SAVE_STATE_PATH working_directory + "save-state.json"

// if the save state should be loaded on game start
#macro SAVE_STATE_AUTOLOAD true

// the number of state frames to store for stepping
#macro STATE_BUFFER_LENGTH 60

// -----------
// -- ivars --
// -----------

// the visible state
state = struct_copy(global.plumber_state);

// the state buffer
state_buffer = ring_create(STATE_BUFFER_LENGTH);

// the save state
state_saved = struct_copy(state);

// if the game is paused
debug_is_paused = false;

// how steps to move, if paused
debug_step_offset = 0;

// -------------
// -- methods --
// -------------

/// if the game is currently paused
function is_paused() {
	return debug_is_paused && debug_step_offset <= 0;
}

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
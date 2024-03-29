
//current state

// ---------------
// -- constants --
// ---------------

//#macro SAVE_STATE_PATH     "/Users/yoyo/Desktop/GameDev/pipeworldGit/pipeworld/yOYo/BLANK GAME/datafiles/save-state.json"
#macro SAVE_STATE_PATH     working_directory + "save-state.json"
#macro SAVE_STATE_AUTOLOAD true

// -----------
// -- ivars --
// -----------

is_paused = false;

// the current state
state = struct_copy(global.plumberstate);

state_buffer = ring_create(60);
// the save state
state_saved = struct_copy(state);


//paused
is_paused = false;
step_offstep = 0;

function paused()
{
	return is_paused && step_offstep <= 0;
}


// ----------------
// -- save state --

// ----------------

function save_mario_json()
{
	json_write(SAVE_STATE_PATH, state)
	
}

function load_mario_json()
{
	state = struct_copy(json_read(SAVE_STATE_PATH))	
}


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
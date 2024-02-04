// -----------
// -- ivars --
// -----------

// the current state
state = struct_copy(global.plumber_state);

// the save state
state_saved = struct_copy(state);

// ----------------
// -- save state --
// ----------------

// load the save state
function load_state() {
	state = struct_copy(state_saved);
}

// save the current state as a save state
function save_state() {
	state_saved = struct_copy(state);
}

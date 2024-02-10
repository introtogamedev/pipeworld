// ---------------
// -- constants --
// ---------------

#macro I_KEY_PAUSE   ord("I")
#macro I_KEY_REWIND  ord("O")
#macro I_KEY_ADVANCE ord("P")

// -------------
// -- stepper --
// -------------

// check input to determine if we're paused and move the stepper
// into the correct position

// preserve the pause state
var _is_paused = debug_is_paused;

// by default, don't step foward when paused
var _step_offset = 0;

// toggle pause when pressed
if (keyboard_check_pressed(I_KEY_PAUSE)) {
	_is_paused = !_is_paused;
}
// advance to next state when advance is pressed
else if (keyboard_check_pressed(I_KEY_REWIND)) {
	if (!_is_paused) {
		_is_paused = true;
	} else {
		_step_offset = -1;
	}
}
// advance to next state when advance is pressed
else if (keyboard_check_pressed(I_KEY_ADVANCE)) {
	if (!_is_paused) {
		_is_paused = true;
	} else {
		_step_offset = 1;
	}
}


debug_is_paused = _is_paused;
debug_step_offset = _step_offset;

// ------------
// -- update --
// ------------

// update the state buffer, rewinding if necessary or adding a
// copy of the next state to the buffer if simulating

// if rewinding, remove the most recent frame from the buffer
if (debug_step_offset < 0) {
	ring_pop(state_buffer);
}
// if unpaused or advancing, add a new state to the buffer
else if (!debug_is_paused || debug_step_offset > 0) {
	ring_push(state_buffer, struct_copy(state));
}

// and always show the most recent state
state = ring_head(state_buffer);
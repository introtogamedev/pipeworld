// ---------------
// -- constants --
// ---------------

#macro I_KEY_PAUSE   ord("I")
#macro I_KEY_ADVANCE ord("P")

// -------------
// -- stepper --
// -------------

// check input to move the stepper into the correct position

// preserve the pause state
var _is_paused = debug_is_paused;

// by default, don't step foward when paused
var _step_offset = 0;

// toggle pause when pressed
if (keyboard_check_pressed(I_KEY_PAUSE)) {
	_is_paused = !_is_paused;
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

// if we're paused, do nothing
if (debug_is_paused) {
	return;
}


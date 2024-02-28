#macro I_KEY_PAUSE (ord("I"))
#macro I_KEY_ADVANCE (ord("P"))

//stepper


var _is_paused = debug_is_paused;

var _step_offset = 0;

//toggle paused when pressed
if (keyboard_check_pressed(I_KEY_PAUSE)){
	_is_paused = !_is_paused;
}

else if (keyboard_check_pressed(I_KEY_ADVANCE)) {
	if !_is_paused {
		_is_paused = true;
	}
	else {
	_step_offset = 1;
	}
}

debug_is_paused = _is_paused;
debug_step_offset = _step_offset;

//to step, have to create ring array as a buffer to push and pop states
//final line: state = ring_head(state_buffer)
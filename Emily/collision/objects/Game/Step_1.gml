#macro KEY_PAUSE   ord("P")
#macro KEY_REWIND  ord("I")
#macro KEY_ADVANCE ord("O")



var _is_paused = debug_is_paused;
var _step_offset = 0;

if (keyboard_check_pressed(KEY_PAUSE))
{
	_is_paused = !_is_paused;
}
else
if (keyboard_check_pressed(KEY_REWIND))
{
	if (!_is_paused)
	{
		_is_paused = true;
		
	}
	else
	{
		_step_offset = -1;
	}
}
else
if (keyboard_check_pressed(KEY_ADVANCE))
{
	if (!_is_paused)
	{
		_is_paused = true;
	}
	else
	{
		_step_offset = 1;
	}
}


debug_is_paused = _is_paused;
debug_step_offset = _step_offset;


//UPDATE
if (debug_step_offset < 0)
{
	ring_pop(state_buffer);
}
//if unpaused/advancing, add new state to buffer
else if (!debug_is_paused || debug_step_offset > 0)
{
	ring_push(state_buffer, struct_copy(state));
}

state = ring_head(state_buffer);
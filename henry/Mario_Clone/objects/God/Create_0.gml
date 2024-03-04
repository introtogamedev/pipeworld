//and on the seventh day
//god played super mario bros

//the game's current state
state = global.plumber_state;

//the current saved state
saved_state = global.plumber_state;

//if the game is paused
debug_is_paused = false;

//how many steps to move if paused
debug_step_offset = 0;

//if the game is currentl paused
function is_paused(){
	return debug_is_paused && debug_step_offset <= 0;
}




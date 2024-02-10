// ---------------
// -- constants --
// ---------------

#macro I_KEY_PAUSE ord("I")

// -------------
// -- stepper --
// -------------

// toggle pause when pressed
if (keyboard_check_pressed(I_KEY_PAUSE)) {
	debug_is_paused = !debug_is_paused;	
}
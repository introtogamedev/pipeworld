/// @description Debugging Tools Trigger
#region debugging tools START
tempframe = false;
if (DEBUG_MODE){
	if (keyboard_check_pressed(INPUT_PAUSE)){
		pause = true
	}if(keyboard_check_released(INPUT_PAUSE)){
		pause = false
	}
	
	if (keyboard_check_pressed(INPUT_DEBUG_NEXTFRAME)){
		tempframe = true;
	}
}
#endregion











#macro KEY_PAUSE ord ("P")
#macro KEY_FRAME ord ("O")

//pause if pause key is pressed
if (keyboard_check_pressed(KEY_PAUSE))
{
	game.debug_is_paused = !game.debug_is_paused;	
}







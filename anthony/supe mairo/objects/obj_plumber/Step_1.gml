#macro KEY_PAUSE ord ("P")
#macro KEY_FRAME ord ("O")

//pause if pause key is pressed
if (keyboard_check_pressed(KEY_PAUSE))
{
	game.debug_is_paused = !game.debug_is_paused;	
}

frame ++;
//show_debug_message(frame);
if (keyboard_check_pressed(KEY_FRAME))
{
	game.debug_is_paused = false;
	frame = 0;
	if (frame >= 1)
	{
		game.debug_is_paused = true;
	}
} 





//collide w player
if (place_meeting(x,y,Obj_player))
	{
		audio_play_sound(snd_one_up, 10, false);
		instance_destroy()
	}
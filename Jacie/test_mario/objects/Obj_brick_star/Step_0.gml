
//stops bounce if alr hit
if (sprite_index == Spr_block_hit) && (y == initial_y)
	{
		exit;
	}


//check collisions with player
if (place_meeting(x,y+1,Obj_player)&& place_meeting(x,y+1,Obj_follower))
	{
		bouncing = true;
		audio_play_sound(snd_powerup_spawn, 10, false);
		sprite_index = Spr_block_hit;
		instance_create_layer(x,y-16,"Powerups", Obj_star);
	}
	
//bouncing anim
if (bouncing)
	{
		y -= 1;
		if (y == initial_y - 8) bouncing = false;
	}
if (!bouncing)
	{
		if (y != initial_y) y += 1;
	}

	
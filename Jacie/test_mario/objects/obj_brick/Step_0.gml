//check collisions with player
if (place_meeting(x,y+1,Obj_player) && place_meeting(x,y+1,Obj_follower))
	{
		bouncing = true;
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
	
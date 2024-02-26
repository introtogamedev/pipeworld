//collision_move(objects);
function collision_move(objects)
		{
	
			//horizontal
			if (place_meeting(x+hsp, y, argument[0]))
				{
					//one pixel above or below
					while(!place_meeting(x+sign(hsp),y, argument[0]))
						{
							x += sign(hsp);
						}
						hsp = 0;
				}
			//update x
			x += hsp;
			//verticle
			if (place_meeting(x, y +vsp, argument[0]))
				{
					//one pixel above or below
					while(!place_meeting(x,y+sign(vsp), argument[0]))
						{
							y += sign(vsp);
						}
						vsp = 0;
				}
			//update y
			y += vsp;


		}
		
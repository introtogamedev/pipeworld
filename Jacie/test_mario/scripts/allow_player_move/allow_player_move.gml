///allow_player_move();
//-------movement
function allow_player_move()
	{
	//decellerate
	if ((!input.right) && (!input.left))
		{
			hsp = lerp(hsp, 0, ac*1.5);
			if (hsp < 0.09) && (hsp > -0.09)
				{
					hsp = 0;
				}
		}
	//move right
	if (input.right)
		{
			hsp += ac;
			if (hsp >= max_spd) hsp = max_spd;
		}

	
	//move left
	if (input.left)
		{
			hsp -= ac;
			if (hsp <= -max_spd) hsp = -max_spd;
		}
	}
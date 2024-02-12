//-------movement
switch(state)
	{
		case("IDLE"):
			{

				last_state = "IDLE";
				sprite_index = Spr_idle;
				image_speed = 0;
				
				hsp = lerp(hsp, 0, ac*1.5);
				if (hsp < 0.09) && (hsp > -0.09)
					{
						hsp = 0;
					}
				//check for inputs
				if (input.a) && (vsp == 0) state = "JUMPING_IN";
				if (input.right) state = "RIGHT";
				if (input.left) state = "LEFT";
				
		
				break;
			}
			
		case("RIGHT"):
			{
				
				last_state = "RIGHT";
				//left
				if (hsp < 0) sprite_index = Spr_stop;
				else sprite_index = Spr_walk;
				image_xscale = 1;
				
				allow_player_move()
				//absolute value of hsp
				image_speed = (abs(hsp)/max_spd)*animation_spd;
				
				//check for inputs
				if (input.a) && (vsp == 0) state = "JUMPING_IN";
				if (input.left) state = "LEFT";
				//means not moving
				if (hsp = 0) state = "IDLE";
				
				break;
			}
		case("LEFT"):
			{
				
				last_state = "LEFT";
				//right
				if (hsp > 0) sprite_index = Spr_stop;
				else sprite_index = Spr_walk;
				image_xscale = -1;
				
				
				allow_player_move()
				//fasteer we go faster we animate
				image_speed = (abs(hsp)/max_spd)*animation_spd;
			
				//check for inputs
				//if push jump and not jumping
				if (input.a) && (vsp == 0) state = "JUMPING_IN";
				if (input.right) state = "RIGHT";
				//means not moving
				if (hsp = 0) state = "IDLE";
		
				
				break;
			}
		case("JUMPING_IN"):
			{
				
//--- initialize jumping
				sprite_index = Spr_jump;
				
				image_speed = 0;
				
				vsp = -jump_spd;
				
				state = "JUMPING";
				allow_player_move()
				
				
				break;
			}
		case("JUMPING"):
			{
//---jumping
			
				
				allow_player_move()
			//DIFF HEIGHTS
				if ((vsp < 0) && (!input.a_held)) 
					{
						vsp = max(vsp, -jump_spd/2);
					}
				
				if (vsp == 0)
					{
						if (place_meeting(x,y+1,par_solid))
							{
								state = last_state;
							}
					}
				else 
				{
					if (place_meeting(x,y+vsp,par_solid)) state = last_state;
				}
				
				break;
			}
			
	}
//------gravity
if (vsp < 5) vsp += grav; 



//view controls
//going right
if (x > camera_get_view_x(view_camera[0]) + (view_get_wport(0)/2) && sign(hsp) == 1)
	{
		camera_set_view_pos(view_camera[0], (camera_get_view_x(view_camera[0]) +hsp), 0);
	}

//Stop player going left 
if (x-8 <= camera_get_view_x(view_camera[0]) && sign(hsp)== -1)
	{
		hsp = 0;
	}
	
//---------collisions

collision_move(par_solid);




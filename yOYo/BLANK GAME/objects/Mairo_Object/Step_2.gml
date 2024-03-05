#macro SIDE_OFFSET_Y 8

if (Game.paused())
{
	return;
}

var _x0 = state.px;
var _x1 = _x0 + sprite_width;
var _y0 = state.py;
var _y1 = _y0 + sprite_height;

//collision
var _is_on_ground = false;

//level boundary


//head
if (state.vy < 0) 
	{
	if (level_collision(state.px+8, state.py) = TILES_BRICK) 
		{
		//_py_collision_head += ((py % 16)+2);
		state.vy = 0;
		//py = _py_collision_head;
		show_debug_message("Head");
		}
	}
	
	
//not actually done exactly how mario would do as there isnt a ground snap check
//ground
if (state.vy > 0) 
{
	if ((level_collision(_x0+2, _y1) = TILES_BRICK) or //left foot
	(level_collision(_x0+14, _y1) = TILES_BRICK))//right foot
	{	
		if (_y1 - level_collision_position(_x0+2, _y1)._y < 4) 
		{
			//this does not work... never enters this state
			state.py -= state.py % 16 - 1;
			state.vy = 0;
			show_debug_message("GCSnap");
		}else
		{
			state.py -= 1;
			state.vy = 0;
			//show_debug_message("GCPush");
		}
		
	// and track that we're on ground
		
	}
	
	
}

//check 1 pixel below the chrarcter see if on ground
if ((level_collision(_x0+2, _y1+1) = TILES_BRICK) or //left foot
	(level_collision(_x0+14, _y1+1) = TILES_BRICK))//right foot
	{	
		_is_on_ground = true;
		//show_debug_message("Ground");
	}



//left
if (level_collision(state.px, state.py+SIDE_OFFSET_Y) = TILES_BRICK){
		//_py_collision_head += ((py % 16)+2);
		
		state.px += 1;
		state.vx = 0;
		//py = _py_collision_head;
		show_debug_message("left");
}

//right
if (level_collision(state.px+16, state.py+SIDE_OFFSET_Y) = TILES_BRICK){
		//_py_collision_head += ((py % 16)+2);
		state.px -= 1;
		state.vx = 0;
		//py = _py_collision_head;
		show_debug_message("right");
}




//state update
state.on_ground = _is_on_ground;
state.jumping = !_is_on_ground;
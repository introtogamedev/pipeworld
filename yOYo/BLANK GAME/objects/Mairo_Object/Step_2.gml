#macro SIDE_OFFSET_Y 8


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
		
		state.py -= 1;
		state.vy = 0;
	// and track that we're on ground
		show_debug_message("GroundCollision");
	}
}

//check ground this happens if you are falling or not
if ((level_collision(_x0+2, _y1+1) = TILES_BRICK) or //left foot
	(level_collision(_x0+14, _y1+1) = TILES_BRICK))//right foot
	{	
		_is_on_ground = true;
		show_debug_message("Ground");
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
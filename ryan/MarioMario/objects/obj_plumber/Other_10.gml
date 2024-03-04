/*
var left_tile = x - sprite_width/2 / tilemap_get_cell_x_at_pixel()
var right_tile = x + sprite_width/2 / tilemap.tile_width
var top_tile = y - sprite_height / tilemap.tile_height
var bottom_tile = y/ tilemap.tile_height

//tile detection boundries
if(left_tile < 0) left_tile = 0
if(right_tile > tilemap.width) right_tile = tilemap.width
if(top_tile < 0) top_tile = 0
if(bottom_tile > tilemap.height) bottom_tile = tilemap.height

var any_collision = false
for(var i = left_tile -1 ; i <= right_tile; i++)
{
	for(var j = top_tile; j <= bottom_tile; j++)
	{
		var tile = tilemap_get_at_pixel()
		if(t.is_wall)
		{ 
			any_collision = true
		}
	}
}

//CHECK METHOD 2
#region Collision Checks
//collision check: floor
if (tilemap_get_at_pixel(tilemapID, x, checkypos) == TILE_FLOOR_ID){
	//show_debug_message("PLUMBER ON GROUND")//debug purposes
	y -= y%tilemap_get_tile_height(tilemapID);
	yvelocity = 0;
	onGround = true;
}else{
	onGround =false;
}	


for (var i = 0; i < abs(yvelocity); i ++){
	var checkypos = y + 1 * sign(yvelocity);
	if (tilemap_get_at_pixel(tilemapID, x, checkypos) == TILE_FLOOR_ID){
		//show_debug_message("PLUMBER ON GROUND")//debug purposes
		y -= 1%y;
		yvelocity = 0;
		onGround = true;
		break;
	}else{
		y++
		onGround =false;
	}	
}

place_meeting(x, y, tileMapLayer)


//horizontal acceleration and collision
for (var i = 0; i <= abs(x_velocity); i++){
	if ( not place_meeting(x + sign(x_velocity), y, obj_wall)){
		x += sign(x_velocity) *1;
		if ( place_meeting(x, y, obj_collidable)){
			var collidable = instance_place(x, y, obj_collidable){
				with (collidable){
					execute_collidable(2);
				}
			}
		}
	}else{
		x_velocity = 0; 
	}
}
x += x_velocity%1

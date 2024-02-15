#region Collision Checks 



/*
//integrate velocity into x - position
x += xvelocity*deltaTime;


//clamp x position
if (x > (room_width - abs(sprite_width)/2) or x < (0 + abs(sprite_width/2))){
	x = clamp(x, 0 + abs(sprite_width/2), room_width - abs(sprite_width/2));
	xvelocity = 0;
}

//horizontal acceleration and collision
for (var i = 0; i <= abs(xvelocity); i++){
	if (tilemap_get_at_pixel(tilemapID, x + sign(xvelocity), y-1) != TILE_FLOOR_ID){
		x += sign(xvelocity) *1;
	}else{
		
		xvelocity = 0; 
		break;
	}
}
x += xvelocity%tilemap_get_tile_width(tilemapID);


#endregion


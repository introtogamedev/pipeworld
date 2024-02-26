///@description Collision checks
if (pause and not tempframe){
	return;
}
#region Collision Checks 

#region collision checks & movement: Horizontal
var xmove = xvelocity * deltaTime;
var xcollided = false;
var xcheck = function (xmove){
	return x + (sign(xmove) *(SPRITE_X_OFFSET + 1));
}

for (var i = 0; i < abs(xmove); i++){
	if (tilemap_get_at_pixel(tilemapID, xcheck(xmove), y-8) != TILE_FLOOR){
		x += sign(xmove);
	}else{
		xcollided = true;
		xvelocity = 0;
	}
}
if (xcollided){
	var clampTileXIndex = 0; //initialize to 0
	if (xcheck(xmove) > x){//right check/collide
		clampTileXIndex = tilemap_get_cell_x_at_pixel(tilemapID, xcheck(xmove), y)-1
	}else{
		clampTileXIndex = tilemap_get_cell_x_at_pixel(tilemapID, xcheck(xmove), y)+2
	}
	x = tilemap_get_tile_width(tilemapID)* clampTileXIndex + SPRITE_X_OFFSET*sign(xmove);	
}else{
	x += xmove%1	
}

//clamp x position
if (x > (room_width - abs(sprite_width)/2) or x < (0 + abs(sprite_width/2))){
	x = clamp(x, 0 + abs(sprite_width/2), room_width - abs(sprite_width/2));
	xvelocity = 0;
}
#endregion

#region collision checks & movement: Vertical
var ymove = yvelocity * deltaTime
var ycollided = false;
var ycheck = function (ymove){
	if (ymove >= 0){
		return  y + 1;
	}else{
		return y - sprite_height - 1;
	}
}
var ycheck_block_collided = function(_ycheck, blockid){
	if (_ycheck > y ){//check bottom
		if (tilemap_get_at_pixel(tilemapID, x - SPRITE_FOOT_OFFSET, _ycheck) == blockid or 
		tilemap_get_at_pixel(tilemapID, x + SPRITE_FOOT_OFFSET - 1, _ycheck) == blockid){
			return true;
		}
	}else{
		if (tilemap_get_at_pixel(tilemapID, x, _ycheck) == blockid){
			return true;
		}
	}
	return false
}

for (var i = 0; i < abs(ymove); i++){
	//NOTE: for right corner check, the check point is right corner-1 due to tile boundries, checking unintentional tile. 
	if (ycheck_block_collided(ycheck(ymove), TILE_FLOOR) == false){ 
		onGround = false;
		y += sign(ymove);
	}else{
		ycollided = true;
		yvelocity = 0;
	}
}
if (ycollided){
	var clampTileYIndex = 0;//initialize to 0;
	if (ycheck(ymove) >= y ){//bottom check/collide
		clampTileYIndex = tilemap_get_cell_y_at_pixel(tilemapID, x, ycheck(ymove))
		onGround = true
	}else{//upwards check/collide
		clampTileYIndex = clamp(tilemap_get_cell_y_at_pixel(tilemapID, x, ycheck(ymove)) + 2, 0, tilemap_get_height(tilemapID));
	}
	y = tilemap_get_tile_height(tilemapID)* clampTileYIndex;
}else{

	y += ymove%1//add remainder
}
#endregion

#endregion


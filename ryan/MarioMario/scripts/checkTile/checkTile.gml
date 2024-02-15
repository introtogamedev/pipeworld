//***NOT USED CODE

//---------------------
//------FUNCTIONS------
//---------------------
//*note: some functions seems not able to collapse with #region

 enum tile_type{
	FLOOR,
	CEILING,
	WALL,
}
/**
 * Determins whether the tile at the position is of the specified ile type.
 * @param {real} _x x position to check
 * @param {real} _y y position to check
 * @param {Constant.tile_type} tiletype - type of tile
 * @returns {Bool} The values that have been added together
 */
function checkTile(_x, _y, tiletype){
	var TILE_FLOOR_IDS = [1];
	var TILE_CEILING_IDS = []; 
	var TILE_WALL_IDS = [1];
	switch(tiletype){
		case tile_type.FLOOR:
			for (var i = 0; i < array_length(TILE_FLOOR_IDS); i ++){
				if(tilemap_get_at_pixel(tilemapID, _x, _y) == TILE_FLOOR_IDS[i]){
					return true;
				}
			}
		break;
		
		case tile_type.CEILING:
			for (var i = 0; i < array_length(TILE_CEILING_IDS); i ++){
				if(tilemap_get_at_pixel(tilemapID, _x, _y) == TILE_CEILING_IDS[i]){
					return true;
				}
			}
		break;
		
		case tile_type.WALL:
			for (var i = 0; i < array_length(TILE_WALL_IDS); i ++){
				if(tilemap_get_at_pixel(tilemapID, _x, _y) == TILE_WALL_IDS[i]){
					return true;
				}
			}
	}
	return false;
}

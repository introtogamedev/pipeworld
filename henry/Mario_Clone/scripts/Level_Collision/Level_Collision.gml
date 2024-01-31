
//constants
#macro TILES_NAME "Tiles"
#macro TILES_NONE 0
#macro TILES_BRICK 1


function level_collision(_x, _y){

	//given an x and y position what tiles is there? 
	var _current_tile = layer_tilemap_get_id(TILES_NAME);
	
	return tilemap_get_at_pixel(_current_tile, _x, _y);
		
	
	
}
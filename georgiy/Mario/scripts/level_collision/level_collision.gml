// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
/*#macro TILES_NAME "Tiles_1"

function tile_empty(i_x, i_y){
return tile_get_empty((tilemap_get_at_pixel(layer_tilemap_get_id(TILES_NAME), i_x, i_y)))
}
*/


// constants
#macro TILES_NAME "Tiles_1"
#macro TILES_NONE  0
#macro TILES_BRICK 1

/// given an x and y position, what tile if any, is there
function level_collision(_x, _y) {
	//show_debug_message("Tile value: " + string(level_collision(px, _y1)));

	return tilemap_get_at_pixel(
		layer_tilemap_get_id(TILES_NAME),
		_x,
		_y
	)
}
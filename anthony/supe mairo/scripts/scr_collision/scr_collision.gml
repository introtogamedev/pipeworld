#macro TILES_NAME "Collision"

function scr_collision(_x, _y){
	return tile_get_empty(tilemap_get_at_pixel(layer_tilemap_get_id(TILES_NAME), _x, _y));
}
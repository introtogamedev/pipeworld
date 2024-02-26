
#macro TILES_NAME "Collision"

function tile_empty(i_x,i_y){
	return tile_get_empty((tilemap_get_at_pixel(layer_tilemap_get_id(TILES_NAME),i_x,i_y)));
}


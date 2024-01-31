#macro tile_name "Tiles_1"

function level_collision(i_x,i_y){
	
	return tile_get_empty((tilemap_get_at_pixel(layer_tilemap_get_id(tile_name),i_x,i_y)));
}
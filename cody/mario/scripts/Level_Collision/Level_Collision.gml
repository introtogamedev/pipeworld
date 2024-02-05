// constants
#macro TILES_NAME "Tiles"
#macro TILES_NONE  0
#macro TILES_BRICK 1

/// given an x and y position, what tile if any, is there
function level_collision(_x, _y) {
	return tilemap_get_at_pixel(
		layer_tilemap_get_id(TILES_NAME),
		_x,
		_y
	)
}
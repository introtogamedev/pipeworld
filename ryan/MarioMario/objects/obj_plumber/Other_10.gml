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
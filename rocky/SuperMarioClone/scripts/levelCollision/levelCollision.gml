// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function levelCollision(x,y){
	var tile=layer_tilemap_get_id("Tiles_1");
	var data=tilemap_get_at_pixel(tile,x,y);
	return data;
}
xVel = -1;

yVel = 0;

grounded = false;

tilemap = layer_tilemap_get_id("Stone");

function round_pos(pos){
	pos /= 16;
	pos = round(pos);
	pos *= 16;
	
	return pos;

}
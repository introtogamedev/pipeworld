xVel = starting_vel;

yVel = 0;

grounded = false;

alive = true;



tilemap = layer_tilemap_get_id("Stone");

function round_pos(pos){
	pos /= 16;
	pos = round(pos);
	pos *= 16;
	
	return pos;

}

timer = 30;
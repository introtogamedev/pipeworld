

xVel = 0;
yVel = 0;




holding_left = false;
holding_right = false;


tilemap = layer_tilemap_get_id("Stone");


grounded = false;

running_into_wall = false;

bonk = false;



function round_pos(pos){
	pos /= 16;
	pos = round(pos);
	pos *= 16;
	
	return pos;
	
	
}









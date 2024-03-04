//HORIZONTAL MOVEMENT



#macro GOOMBA_GRAVITY 0.2
#macro MAX_GOOMBA_YVEL 3

//VERTICAL COLLISION

y_collision_goomba = y + sprite_height/2;



if (place_meeting(x, y+4, tilemap)){
	grounded = true;
	
	y_collision_goomba = round_pos(y_collision_goomba);
	
	y = (y_collision_goomba - 12);
	
}else{
	grounded = false;
}


//HORIZONTAL COLLISION

//right
if (place_meeting(x+2, y, tilemap) || (x > room_width - 8)){
	if(grounded = true){
		xVel *= -1;
	}
}

//left
if (place_meeting(x-2, y, tilemap) || (x < 8)){
	if(grounded = true){
		xVel *= -1;
	}
}

yVel += GOOMBA_GRAVITY;
yVel = clamp(yVel,-MAX_GOOMBA_YVEL, MAX_GOOMBA_YVEL);


//WOMP WOMP
if(place_meeting(x, y, obj_plumber)){
	game_end();
}


//MOVEMENT!!!
y += yVel
x += xVel;

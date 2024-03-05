//HORIZONTAL MOVEMENT



#macro GOOMBA_GRAVITY 0.2
#macro MAX_GOOMBA_YVEL 3

//VERTICAL COLLISION

y_collision_goomba = y + sprite_height/2;



if (place_meeting(x, y+4, tilemap)){
	grounded = true;
	
	y_collision_goomba = round_pos(y_collision_goomba);
	
	y = (y_collision_goomba - 11);
	
}else{
	grounded = false;
}


//HORIZONTAL COLLISION

//right
if (place_meeting(x+2, y, tilemap) || (x > room_width - 8) || place_meeting(x+2, y, obj_goomba)){
	if(grounded = true){
		xVel *= -1;
	}
	
}

//left
if (place_meeting(x-2, y, tilemap) || (x < 8) || place_meeting(x-2, y, obj_goomba)){
	if(grounded = true){
		xVel *= -1;
	}
	
}

yVel += GOOMBA_GRAVITY;
yVel = clamp(yVel,-MAX_GOOMBA_YVEL, MAX_GOOMBA_YVEL);


//WOMP WOMP
if(place_meeting(x, y-8, obj_bot_o_plumber)){
	if(sprite_index = spr_goomba_running){
	global.yVel = JUMP_IMPULSE_SMALL;
	}
	sprite_index = spr_goomba_stomped;
	alive = false;
	xVel = 0;

}

if(place_meeting(x, y, obj_plumber)){
	if (alive = true){
		game_end();
	}
}

if (alive = false){
	if(timer > 0){
		timer--;
	}else{
		instance_destroy();
		
	}
}



//MOVEMENT!!!
y += yVel
x += xVel;

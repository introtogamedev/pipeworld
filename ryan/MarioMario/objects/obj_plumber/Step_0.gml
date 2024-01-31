var input_direction = 0;//initialize to 0;
if (keyboard_check(INPUT_LEFT)){
	input_direction -=1;
}if (keyboard_check(INPUT_RIGHT)){
	input_direction += 1;
}

//get fractional delta time
var deltaTime = delta_time/MS

#region horizontal movement
//get the move acceleration/deacceleration
accelx = MOVE_ACCEL * input_direction;
if (input_direction == 0 ){
	accelx = MOVE_DEACCEL * -sign(xvelocity);
}
//integrate acceleration into velocity
xvelocity += accelx * deltaTime
if (abs(xvelocity) <= 0.1){
	xvelocity = 0;
}else{
	xvelocity = clamp(xvelocity, -MAX_SPD, MAX_SPD);
}

//integrate velocity into position
x += xvelocity;

//clamp x position
if (x > (room_width - abs(sprite_width)/2) or x < (0 + abs(sprite_width/2))){
	x = clamp(x, 0 + abs(sprite_width/2), room_width - abs(sprite_width/2));
	xvelocity = 0;
}

//sprite direction
if (sign(image_xscale) != sign(round(xvelocity)) and sign(round(xvelocity)) != 0 and abs(xvelocity) > 0){
	image_xscale = sign(round(xvelocity));
}


#endregion

#region sprite assignment
//RUNNING
if (abs(xvelocity) >= 3){
	sprite_index = spr_marioSPEEDRUN;
}else if (abs(xvelocity) == 0){
	sprite_index = spr_marioIDLE;
}else if (abs(xvelocity) < 1){
	sprite_index = spr_marioRUN;
}


#endregion
/*
the plumber runs




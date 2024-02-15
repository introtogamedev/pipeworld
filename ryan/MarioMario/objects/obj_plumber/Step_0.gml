var input_direction = 0;//initialize to 0;
deltaTime = delta_time/MS;//get fractional delta time

#region debugging tools START
tempframe = false;
if (DEBUG_MODE){
	if (keyboard_check_pressed(INPUT_PAUSE)){
		pause = true
	}if(keyboard_check_released(INPUT_PAUSE)){
		pause = false
	}
	
	if (keyboard_check_pressed(INPUT_DEBUG_NEXTFRAME)){
		tempframe = true;
	}
}
#endregion

if (not pause or tempframe){
#region input detect
if (keyboard_check(INPUT_LEFT)){
	input_direction += (-1);
}if (keyboard_check(INPUT_RIGHT)){
	input_direction += 1;
}

if (keyboard_check_pressed(INPUT_RUN)){
	runActivate = true;
}if(keyboard_check_released(INPUT_RUN)){
	runActivate = false;
}

var jump = false;//initialize to false;
if (keyboard_check(INPUT_JUMP)){
	jump = true;
}

#endregion

#region horizontal movement

#region variable Initialization: runActivate & applying acceleration to xvelovcity
//initialize the movement dependent variables based on runActivate
var accel =  0;//initilize to 0;
var maxSPD = 0; //initilize to 0;
var deaccel = 0; //initiliaze to 0;
if(runActivate == true){
	accel = MOVE_SPRINT_ACCEL;
	maxSPD = MAX_SPD_SPRINT;
	deaccel = MOVE_SPRINT_DEACCEL;
}else{
	accel = MOVE_ACCEL;
	maxSPD = MAX_SPD;
	deaccel = MOVE_DEACCEL;
}

var accelx = 0;//initialize to 0
//get the horizontal move acceleration/deacceleration
accelx = accel * input_direction;

//integrate acceleration into x - velocity
xvelocity += accelx * deltaTime
xvelocity = clamp(xvelocity, -maxSPD, maxSPD);

//resolve if no input is registered. clamps current speed to a minimum of 0
if (input_direction == 0 ){
	var spd = abs(xvelocity);
	spd -= deaccel*deltaTime;
	spd = max(spd, 0);
	xvelocity = spd * sign(xvelocity);
}
#endregion

#region collision checks & movement: Horizontal
var xmove = xvelocity * deltaTime;
var xcollided = false;
var xcheck = function (xmove){
	return x + (sign(xmove) *(SPRITE_X_OFFSET + 1));
}

for (var i = 0; i < abs(xmove); i++){
	if (tilemap_get_at_pixel(tilemapID, xcheck(xmove), y-8) != TILE_FLOOR){
		x += sign(xmove);
	}else{
		xcollided = true;
		xvelocity = 0;
	}
}
if (xcollided){
	var clampTileXIndex = 0; //initialize to 0
	if (xcheck(xmove) > x){//right check/collide
		clampTileXIndex = tilemap_get_cell_x_at_pixel(tilemapID, xcheck(xmove), y)-1
	}else{
		clampTileXIndex = tilemap_get_cell_x_at_pixel(tilemapID, xcheck(xmove), y)+2
	}
	x = tilemap_get_tile_width(tilemapID)* clampTileXIndex + SPRITE_X_OFFSET*sign(xmove);	
}else{
	x += xmove%1	
}

//clamp x position
if (x > (room_width - abs(sprite_width)/2) or x < (0 + abs(sprite_width/2))){
	x = clamp(x, 0 + abs(sprite_width/2), room_width - abs(sprite_width/2));
	xvelocity = 0;
}
#endregion

#region Horizontal Animation Triggers
	if (input_direction != 0 or  xmove != 0){
		plumberAnimation.xmoving = true;
	}else{
		plumberAnimation.xmoving = false;
	}
	
	if (input_direction != 0){
		if (input_direction!= facing_dir){
			plumberAnimation.turning = true;
		}else if (sign(xvelocity) == sign(input_direction)){
			plumberAnimation.turning = false;
		}
		facing_dir = sign(input_direction);
	}
#endregion

#endregion

#region vertical movement

#region variable Initialization: jump & applying gravity to yvelocity
//initialize the y velocity based on jumping or not. 
var _gravity = 0;//initialize to 0;
if (jump and not jumpTriggered and jumpAllowed){
	jumpTriggered = true;
	yvelocity = -abs(JUMP_VEL);
	plumberAnimation.jumping = true;//animation state
}else if (jump and jumpAllowed and jump_height < JUMP_HEIGHT_MAX){
	jump_height += abs(yvelocity) * deltaTime;//stores current jump height
	_gravity = JUMP_GRAVITY;
	//show_debug_message("PLUMBER JUMPING");//dubuggung purposes only
	
}else if (jump_height >= JUMP_HEIGHT_MAX or not jumpAllowed or not jump){
	jumpAllowed = false;//double prevention for both cases. 
	jumpTriggered = false;//reset jump trigger

	_gravity = FALL_GRAVITY;
	//show_debug_message("PLUMBER FALLING");//debugging purposes only
}

//show_debug_message(jump_height);
if (deltaTime <= 0.02){
yvelocity += _gravity* deltaTime;
} 

//clamp terminal velocity
if(yvelocity >= TERMINAL_VELOCITY){
	yvelocity = TERMINAL_VELOCITY;
}

if (onGround){
	jumpAllowed = true;//reinitiate jumpAllowed 
	jump_height = 0;
}

#endregion

#region collision checks & movement: Vertical
var ymove = yvelocity * deltaTime
var ycollided = false;
var ycheck = function (ymove){
	if (ymove >= 0){
		return  y + 1;
	}else{
		return y - sprite_height - 1;
	}
}
var ycheck_block_collided = function(_ycheck, blockid){
	if (_ycheck > y ){//check bottom
		if (tilemap_get_at_pixel(tilemapID, x - SPRITE_FOOT_OFFSET, _ycheck) == blockid or 
		tilemap_get_at_pixel(tilemapID, x + SPRITE_FOOT_OFFSET - 1, _ycheck) == blockid){
			return true;
		}
	}else{
		if (tilemap_get_at_pixel(tilemapID, x, _ycheck) == blockid){
			return true;
		}
	}
	return false
}

for (var i = 0; i < abs(ymove); i++){
	//NOTE: for right corner check, the check point is right corner-1 due to tile boundries, checking unintentional tile. 
	if (ycheck_block_collided(ycheck(ymove), TILE_FLOOR) == false){ 
		onGround = false;
		y += sign(ymove);
	}else{
		ycollided = true;
		yvelocity = 0;
	}
}
if (ycollided){
	var clampTileYIndex = 0;//initialize to 0;
	if (ycheck(ymove) >= y ){//bottom check/collide
		clampTileYIndex = tilemap_get_cell_y_at_pixel(tilemapID, x, ycheck(ymove))
		onGround = true
	}else{//upwards check/collide
		clampTileYIndex = clamp(tilemap_get_cell_y_at_pixel(tilemapID, x, ycheck(ymove)) + 2, 0, tilemap_get_height(tilemapID));
	}
	y = tilemap_get_tile_height(tilemapID)* clampTileYIndex;
}else{

	y += ymove%1//add remainder
}
#endregion

#region Vertical Animation Triggers
if (onGround){
	//animation trigger initialized in jumping initialization
	plumberAnimation.jumping = false;
}
//ymoving = !ycollided;

#endregion

#endregion
}
var input_direction = 0;//initialize to 0;
var deltaTime = delta_time/MS;//get fractional delta time

var tilemapLayer = layer_get_id(TILESET_COLLIDABLE);
var tilemapID = layer_tilemap_get_id(tilemapLayer);

#region input detect
if (keyboard_check(INPUT_LEFT)){
	input_direction = (-1);
	facing_dir = -1;
}if (keyboard_check(INPUT_RIGHT)){
	input_direction = 1;
	facing_dir = 1;
}

if (keyboard_check_pressed(INPUT_RUN)){
	runActivate = true;
}if(keyboard_check_released(INPUT_RUN)){
	runActivate = false;
}

var jump = false;//initialize to false;
if (keyboard_check(INPUT_JUMP) and onGround){
	jump = true;
}
#endregion

#region variable Initialization: runActivate
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
#endregion
#region variable Initialization: jump
//initialize the y velocity based on jumping or not. 
if (jump and jumpAllowed and jump_height < JUMP_HEIGHT_MAX){
	yvelocity = -abs(JUMP_VEL);
}else if (jump_height >= JUMP_HEIGHT_MAX or not jumpAllowed){
	
}else if (){
	
	
}
#endregion

#region horizontal movement
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

//integrate velocity into x - position
x += xvelocity*deltaTime;

//clamp x position
if (x > (room_width - abs(sprite_width)/2) or x < (0 + abs(sprite_width/2))){
	x = clamp(x, 0 + abs(sprite_width/2), room_width - abs(sprite_width/2));
	xvelocity = 0;
}

#endregion

#region vertical movement
//integrate gravity into y - velocity
yvelocity += GRAVITY * deltaTime;

//apply gravity and terminal velocity
if(yvelocity >= TERMINAL_VELOCITY){
	yvelocity = TERMINAL_VELOCITY;
}

//integrate velocity into y - position 
y += yvelocity * deltaTime;

#region Collision Checks
//collision check: floor
if (tilemap_get_at_pixel(tilemapID, x, y) == TILE_FLOOR_ID){
	//show_debug_message("PLUMBER ON GROUND")//debug purposes
	y -= y%tilemap_get_tile_height(tilemapID);
	yvelocity = 0;
	onGround = true;
}else{
	onGround =false;
}	
#endregion


#endregion

#region variable Updates
if (onGround) jumpAllowed = true;
#endregion
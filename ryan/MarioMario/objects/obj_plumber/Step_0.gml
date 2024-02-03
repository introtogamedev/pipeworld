var input_direction = 0;//initialize to 0;
var deltaTime = delta_time/MS;//get fractional delta time

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

#region horizontal movement
var accelx = 0;//initialize to 0
//get the move acceleration/deacceleration
accelx = accel * input_direction;

//integrate acceleration into velocity
xvelocity += accelx * deltaTime
xvelocity = clamp(xvelocity, -maxSPD, maxSPD);

//
if (input_direction == 0 ){
	var spd = abs(xvelocity);
	spd -= deaccel*deltaTime;
	spd = max(spd, 0);
	xvelocity = spd * sign(xvelocity);
}
//integrate velocity into position
x += xvelocity*deltaTime;

//clamp x position
if (x > (room_width - abs(sprite_width)/2) or x < (0 + abs(sprite_width/2))){
	x = clamp(x, 0 + abs(sprite_width/2), room_width - abs(sprite_width/2));
	xvelocity = 0;
}

#endregion

#region vertical movement
yvelocity += GRAVITY;

//apply gravity and terminal velocity
if(yvelocity >= TERMINAL_VELOCITY){
	yvelocity = TERMINAL_VELOCITY;
}
//gravity simulation
/*
var tilemapLayer = layer_get_id("Tilemap_map");
var tilemapID = layer_tilemap_get_id(tilemapLayer);

for (var i = 1; i <= abs(yvelocity); i++){
	if (tilemap_get_at_pixel(tilemapID, x, y + sign(yvelocity)) != TILE_FLOOR_ID){
		y += sign(yvelocity) *1 *deltaTime;
	}else{
		yvelocity = 0;
		onGround = true;
		break;
	}
}

if (jump){
	yvelocity = JUMP_VEL;
	onGround = false;
}

#endregion


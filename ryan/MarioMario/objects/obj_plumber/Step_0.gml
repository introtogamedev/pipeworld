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
if (pause and not tempframe){
	return;
}
#endregion

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

#region Horizontal Animation Triggers
	//intending to move or not
	if (input_direction != 0 or  xvelocity != 0){
		plumberAnimation.xmoving = true;
	}else{
		plumberAnimation.xmoving = false;
	}
	
	//turning & facing direction
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
if (jump and not jumpTriggered and onGround){
	jumpTriggered = true;
	yvelocity = -abs(JUMP_VEL);
	plumberAnimation.jumping = true;//animation state
	playsoundEff(aud_plumberJUMPeff, 10, true);
}else if (jump and yvelocity < 0){//going up
	_gravity = JUMP_GRAVITY;
	//show_debug_message("PLUMBER JUMPING");//dubuggung purposes only
}else if (yvelocity >= 0 or not jump){//going down
	_gravity = FALL_GRAVITY;
	//show_debug_message("PLUMBER FALLING");//debugging purposes only
}
if (not jump){
	jumpTriggered = false;//reset jump trigger	
}

//show_debug_message(jump_height);
if (deltaTime <= 0.02){
yvelocity += _gravity* deltaTime;
} 

//clamp terminal velocity
if(yvelocity >= TERMINAL_VELOCITY){
	yvelocity = TERMINAL_VELOCITY;
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
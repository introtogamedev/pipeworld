///@description Main 
var input_direction = 0;//initialize to 0;
deltaTime = delta_time/MS;//get fractional delta time

if (pause and not tempframe){
	return;
}

#region input detect
if (keyboard_check(INPUT_LEFT)){
	input_direction += (-1);
}if (keyboard_check(INPUT_RIGHT)){
	input_direction += 1;
}

if (keyboard_check(INPUT_RUN)){
	runActivate = true;
}else{
	runActivate = false;
}

var jump = false;//initialize to false;
if (keyboard_check(INPUT_JUMP)){
	jump = true;
}

#endregion

#region horizontal movement

#region variable initialization
//stores whether the input was registered. false if cancelled or not. 
var input_registered = bool(abs(input_direction));
/*stores whether key is held opposite of direction
	1*1 = 1 -> true or -1 * 1 = -1 -> false or 0 * 1 = 0 -> false*/
var oppositeHOLD = not bool(sign(input_direction) * sign(xvelocity) + 1)
//stores the current speed regardless of direction
var currentSPD = abs(xvelocity);
//stopped? boolean function sets false at <0.5. 
var stopped = not bool(currentSPD + 0.5);
//update skidding
if (oppositeHOLD){skidding = true;}
if (stopped or (input_registered and not oppositeHOLD)){
	skidding = false;
}

//default variables
var accel =  WALK_ACCEL; //initiliaze to moving state;
	if (runActivate){
		accel = RUN_ACCEL
	}
	
var deaccel = 0; //initialize to 0
	//if no key pressed, initialize to release_deaccel
	if (input_direction == 0 and not skidding){
		deaccel = RELEASE_DEACCEL;
	}
	//if skidding: holding opposite dir
	if (skidding){
		deaccel = SKIDDING_DEACCEL;
	}

var maxSPD = WALK_SPEED_MAX; //initiliaze to moving state;
if (not runActivate and currentSPD > maxSPD){
	maxSPD = max(maxSPD, currentSPD -1);
}
if (runActivate){
	maxSPD = RUN_SPEED_MAX
}

//air movement/momentum
if(not onGround){

}
//ground movement special cases
else{
		//instant turnaround when skidding
	if (skidding and currentSPD < SKID_TURNAROUND){
		xvelocity *= -1;
	}

	//set minimum of minSpeed if intending to move. 
	if (currentSPD < MIN_WALK_SPD and input_direction != 0 and not oppositeHOLD){
		xvelocity = max(currentSPD, MIN_WALK_SPD)* sign(xvelocity);
	}
	
}
#endregion 


#region applying acceleration to xvelovcity

/*NOTE: Accel and Deaccel are both assigned without any changes to sign 
	because it is decided by player input. 
	
	However there is accel and deaccel, which are dependent on current
	direction. This is solved by accepting accel/deaccel seperately. 
	
	Since accel is always present, this is reliant on the presence of 
	deaccel values. 
*/

var accelx = 0;//initialize to 0
//get the horizontal move acceleration/deacceleration
if (deaccel != 0){
	accelx = deaccel;
}else if (deaccel == 0 ){
	accelx = accel;
}

accelx = accelx* input_direction;

//integrate acceleration into x - velocity
xvelocity += accelx * deltaTime
xvelocity = clamp(xvelocity, -maxSPD, maxSPD);

//resolve if no input is registered. clamps current speed to a minimum of 0
if (not input_registered){
	var spd = abs(xvelocity);
	spd -= deaccel*deltaTime;
	spd = max(spd, 0);
	xvelocity = spd * sign(xvelocity);
}
#endregion

#region Horizontal Animation Triggers
	//intending to move or not
	if (input_registered or  xvelocity != 0){
		plumberAnimation.xmoving = true;
	}else{
		plumberAnimation.xmoving = false;
	}
	//facing direction
	if (input_registered){
		facing_dir = sign(input_direction);
	}
#endregion

#endregion

#region vertical movement

#region variable Initialization: jump & applying gravity to yvelocity
//initialize the y velocity based on jumping or not. 
var _gravity = 0;//initialize to 0;
currentSPD = abs(xvelocity);//update the variable
if (jump and not jumpTriggered and onGround){
	jumpTriggered = true;
	//initialize jumpspeed based on xvelocity
	var jump_vel = 0;
	if (currentSPD < JUMP_VEL_TRIG_SLOW){
		jump_vel = JUMP_VEL_SLOW;
	}else if (currentSPD >= JUMP_HOLD_GRAV_SLOW and currentSPD < JUMP_VEL_FAST){
		jump_vel = JUMP_VEL_MED;
	}else if (currentSPD >= JUMP_VEL_FAST){
		jump_vel = JUMP_VEL_FAST;
	}
	yvelocity = -abs(jump_vel);
	plumberAnimation.jumping = true;//animation state
	playsoundEff(aud_plumberJUMPeff, 10, true);
}else if (jump and yvelocity < 0){//going up
	_gravity = JUMP_HOLD_GRAV_SLOW;
	//show_debug_message("PLUMBER JUMPING");//dubuggung purposes only
}else if (yvelocity >= 0 or not jump){//going down
	_gravity = FALL_GRAV_SLOW;
	//show_debug_message("PLUMBER FALLING");//debugging purposes only
}
if (not jump){
	jumpTriggered = false;//reset jump trigger	
}

//show_debug_message(jump_height);
//if (deltaTime <= 0.02){
yvelocity += _gravity* deltaTime;
//} 

/*clamp terminal velocity
if(yvelocity >= TERMINAL_VELOCITY){
	yvelocity = TERMINAL_VELOCITY;
}
*/
#endregion

#region Vertical Animation Triggers
if (onGround){
	//animation trigger initialized in jumping initialization
	plumberAnimation.jumping = false;
}
//ymoving = !ycollided;

#endregion

#endregion
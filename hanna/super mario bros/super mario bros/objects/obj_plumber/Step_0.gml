// CONSTANTS
// microseconds in a second
#macro MS 100000

#macro MOVE_ACCELERATION 0.2
#macro LEFT ord("A")
#macro RIGHT ord("D")
#macro SPRINT (vk_shift)

//imagex scale = 1/imagex scale = -1;


// STEP
var _input_dir = 0;


if (keyboard_check(LEFT)){
	_input_dir -= 4;
	sprite_index = spr_plumber_running;
	image_xscale = -1;
	if(xVel > 0){
		sprite_index = spr_plumber_turning;
	}
	

}
if (keyboard_check(RIGHT)){
	_input_dir += 4;
	sprite_index = spr_plumber_running;
	image_xscale = 1;
	if(xVel < 0){
		sprite_index = spr_plumber_turning;
	}

}

//IDLE
if (_input_dir = 0){
	sprite_index = spr_plumber_idle;
}



// DRAG
if (xVel > 0 && _input_dir = 0){
	xVel -= 0.1;
	if (xVel < 0.1){
		xVel = 0;
	}	
}

if (xVel < 0 && _input_dir = 0){
	xVel += 0.1;
	if (xVel > -0.1){
		xVel = 0;
	}
}

if(yVel > 0){
	 
	
}


//BOUNDS
if (x < 10){
	xVel = 0;
	_input_dir = clamp(_input_dir,0 ,4)
	
}

if (x > room_width - 10){
	xVel = 0;
	_input_dir = clamp(_input_dir,-4 ,0)
	
}
	


show_debug_message(string(xVel));





// MOVE ACCELERATION
var _ax = MOVE_ACCELERATION * _input_dir;



var dt = delta_time/MS;


// INTEGRATING ACCELERATION INTO VEL

	xVel += _ax * dt;
	
if (keyboard_check(SPRINT)){
		xVel = clamp(xVel, -3, 3);
}else{
		xVel = clamp(xVel, -1.5, 1.5);
}





// UPDATING X POS
x += xVel;
//show_debug_message(string(xVel));



	
	




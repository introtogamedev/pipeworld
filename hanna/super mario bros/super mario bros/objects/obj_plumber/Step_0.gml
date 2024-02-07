// CONSTANTS
// microseconds in a second
#macro MS 100000

#macro MOVE_ACCELERATION 0.2
#macro LEFT ord("A")
#macro RIGHT ord("D")
#macro SPRINT (vk_shift)

#macro JUMP ord("W")

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



//BOUNDS
if (x < 10){
	xVel = 0;
	_input_dir = clamp(_input_dir,0 ,4)
	
}

if (x > room_width - 10){
	xVel = 0;
	_input_dir = clamp(_input_dir,-4 ,0)
	
}
	


//show_debug_message(string(xVel));





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

//JUMP??






yVel += grav;
yVel = clamp(yVel, -yVel_max, yVel_max);

//VERT COLLISION
if (place_meeting(x, y, tilemap)){
	grounded = 1;
	
	yVel =0;
	
	if ((keyboard_check(JUMP)) && grounded = 1){
	yVel += jump;
	
	show_debug_message("IM JUMPING");

}
if (yVel < 0 and (!keyboard_check_pressed(JUMP))){
	yVel = max(yVel, jump/jump_mod)
}

	
}else{
		grounded = 0;
}

// UPDATING X POS
x += xVel;
//show_debug_message(string(xVel));


y += yVel;

show_debug_message(string(yVel));


	
	




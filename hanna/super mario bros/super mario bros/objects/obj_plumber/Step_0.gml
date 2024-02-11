// CONSTANTS
// microseconds in a second
#macro MS 100000

#macro MOVE_ACCELERATION 0.2
#macro LEFT ord("A")
#macro RIGHT ord("D")
#macro SPRINT (vk_shift)

#macro JUMP ord("W")

#macro JUMP_IMPULSE -10
#macro JUMP_ACCELERATION 0.2
#macro GRAVITY 0.2
#macro YVEL_MAX 4

y_collision_top = y - sprite_height/2;

y_collision_bottom = y + sprite_height/2;

x_collision_right = x + sprite_width/2;

x_collision_left = x - sprite_width/2;



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
if (x < 8){
	
	x = 8;
	
	xVel = 0;
	
	
	
	_input_dir = clamp(_input_dir,0 ,4)
	
}


if (x > room_width - 8){
	x = room_width - 8;
	
	xVel = 0;
	_input_dir = clamp(_input_dir,-4 ,0)
	
	
}
	


//show_debug_message(string(xVel));



//JUMP??

yVel += GRAVITY;
yVel = clamp(yVel, -YVEL_MAX, YVEL_MAX);

/* TY'S COLLISION
// check for ground collision
var _py_collision = y;

// get the bottom of the character
var _y1 = y + sprite_height/2;

// if it is colliding with a tile
if (place_meeting(x, _y1, tilemap)) {
	// then move the player to the top of the tile
	grounded = true;
	_py_collision -= y % 16;
	if ((keyboard_check_pressed(JUMP)) && grounded = 1){
		yVel += JUMP_IMPULSE;
		
	}
}else{
	grounded = false;
}

// if we hit ground, move to the top of the block
if (y != _py_collision) {
	y = _py_collision;
	vVel = 0;
}


192
194
193.20

192/16 = 12
194/16=12.125
193.20/16 = 12.075
191.90/16 = 11.99375


*/

//VERT COLLISION
//BOTTOM COLLISION
if(grounded = false){
	sprite_index = spr_plumber_jumping;

}

if (place_meeting(x, y+2, tilemap)){
	
	y_collision_bottom = round_pos(y_collision_bottom);
	
	y = (y_collision_bottom - 8);
	
	grounded = true;
	yVel = 0;
	
	if ((keyboard_check_pressed(JUMP)) && grounded = true){
		yVel += JUMP_IMPULSE;
		sprite_index = spr_plumber_jumping;
	}


}else{
		grounded = false;
}

//TOP COLLISION
if (place_meeting(x, y-2, tilemap)){
	bonk = true;
} else{
	bonk = false;
}


if (bonk = true){
	sprite_index = spr_plumber_jumping;
}




//show_debug_message(string(grounded));

// HORIZONTAL COLLISION
//right
if (place_meeting(x+2, y, tilemap)){
	

	
	xVel = 0;
	_input_dir = clamp(_input_dir, -4, 0)

}
//left
if (place_meeting(x-2, y, tilemap)){
	
	
	
	xVel = 0;
	_input_dir = clamp(_input_dir,0 ,4)
}


// MOVE ACCELERATION
var _ax = MOVE_ACCELERATION * _input_dir;
//var _ay = JUMP_ACCELERATION * jump;


var dt = delta_time/MS;


// INTEGRATING ACCELERATION INTO VEL

	xVel += _ax * dt;
	//yVel += _ay * dt;

	
if (keyboard_check(SPRINT)){
		xVel = clamp(xVel, -3, 3);
}else{
		xVel = clamp(xVel, -1.5, 1.5);
}



// UPDATING X POS
x += xVel;
//show_debug_message(string(xVel));

// UPDATING Y POS
y += yVel;

//show_debug_message(string(grounded));




	
	




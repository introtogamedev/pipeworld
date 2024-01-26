//
#macro MILLISECONDS 1000000
#macro DT 0.01666667
#macro MOVE_ACCCELERATION 5
#macro INPUT_LEFT ord("A")
#macro INPUT_RIGHT ord("D")
#macro MOVE_SPEED 5

// step
function step(){
	var _input_dir = 0;
	if (keyboard_check(INPUT_LEFT)){
		_input_dir -= 1;
	}
	if (keyboard_check(INPUT_RIGHT)){
		_input_dir += 1;
	}
	// get move acceleration
	var _acceleration_x = MOVE_ACCCELERATION * _input_dir;
	var _dt = delta_time / MILLISECONDS;
	
	// friction
	if (_input_dir == 0 && velocity_x != 0){
		_acceleration_x = (-sign(velocity_x)) * friction_constant;
	}

	// decides direction
	if (velocity_x > 0){
		if (last_orientation == -1){
			last_orientation = 1;
			sprite_changed = false;
		} else if (mario_static == true){
			sprite_changed = false;
		}
		mario_static = false;
	} else if (velocity_x < 0){
		if (last_orientation == 1){
			last_orientation = -1;
			sprite_changed = false;
		} else if (mario_static == true){
			sprite_changed = false;
		}
		mario_static = false;
	} else {
		if (mario_static == false){
			sprite_changed = false;
			mario_static = true;
		}
	}
	
	// integrate acceleration into velocity
	if (velocity_x < max_speed && velocity_x > -max_speed){
		velocity_x += _acceleration_x * _dt;
	} else if (met_wall){
		velocity_x = 0;
	} else if ((velocity_x > max_speed || velocity_x < -max_speed) && _input_dir != 0) {
		velocity_x = max_speed * last_orientation;
	} else {
		velocity_x += _acceleration_x * _dt;
	}
	
	//lowering velocity to zero when about to stop
	if (-0.1 < velocity_x && velocity_x < 0.1 && !keyboard_check(vk_anykey)){
		velocity_x = 0;
	}
	
	//
	if (!sprite_changed){
		if (!mario_static){
			sprite_index = mario_running;
			if (last_orientation == 1){
				image_xscale = 1;
			} else {
				image_xscale = -1;
			}
		} else if (mario_static){
			sprite_index = mario_sprite;
			if (last_orientation == 1){
				image_xscale = 1;
			} else {
				image_xscale = -1;
			}
		}
		sprite_changed = true;
	}
	
	if (place_meeting(x + velocity_x, y, off_screen_wall)){
		met_wall = true;
		while (!place_meeting(x + sign(velocity_x), y, off_screen_wall)){
			x = x + sign(velocity_x);
			
		}
		velocity_x = 0;
	} else {
		met_wall = false;
	}
	
	
	//integrate velocity into posiiton
	x += velocity_x;
	
	//keeping mario in room
	if (x < 8){
		x = 8;
		//show_debug_message("hi");
	}
	if (x + sprite_width/2 > room_width){
		x = room_width - sprite_width/2;
	}
	
}

// run
step();
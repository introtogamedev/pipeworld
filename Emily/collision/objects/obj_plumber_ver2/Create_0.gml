on_floor = false;
falling = false;
jumping = false;

falling_gravity = 0.3;
falling_max_velocity = 8;

jump_acceleration = 1.5;
jump_initial_impulse = 2;
jump_max_velocity = 10;
jump_timer = 0;
jump_duration = 16;

//state
global.state = {
	// current frame
	frame_index: 0,

	//current velocity
	vx: 0,
	vy: 0,

	//current position
	px: x,
	py: y,

	is_running: false,

	is_jump_held: false,

	is_on_ground: false,
	
	// the current look direction
	look_dir: 0,

	// the current input move dir
	input_move: 0,
}


//ivars
game = instance_nearest(0, 0, Game);

//current state
state = undefined;
on_floor = false;
falling = false;
jumping = false;

jump_timer = 0;
jump_duration = 20;

run_timer = 0;
walk_timer = 0;
run_duration = 20;

//state
global.state =
{
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


frame = 0;


//ivars
game = instance_nearest(0, 0, Game);

//current state
state = undefined;
frame = 0;


//-------
//state template
//-------
global.plumber_state = {

	frame_index: 0,

	// current velocity 
	vx: 0,
	vy: 0,

	// current position
	px: 0,
	py: 0,

	//the current look direction
	look_dir: 0,
	prev_look_dir: 1,


	//the current imput direction
	input_dir: 0,

	//movement state
	is_on_ground: false,
	is_running: false,
	is_jumping: false,
	is_jump_held: false,
	falling_from_collision: false,
	is_sprinting: false,

	//visual state
	anim_is_jumping: false,
	anim_move_frame: 0,
	anim_image_index: 0,
	
	//should replace both of these with ^^^
	// the current position in the move animation
	move_frame: 0,

	//the current sprite index
	image_idx: 0,

}

//var _a = global.plumber_state;
//var _b = struct_copy(_a);

//------
//--ivars--
//-------
state = undefined;

game = instance_nearest(0, 0, God);

// cd Documents/School/GameDev/pipeworld/henry




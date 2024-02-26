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


	//the current imput direction
	input_dir: 0,

	//movement state
	is_on_ground: false,
	is_running: false,
	is_jump_held: false,

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

//------
//--ivars--
//-------
state = undefined;

// cd Documents/School/GameDev/pipeworld/henry




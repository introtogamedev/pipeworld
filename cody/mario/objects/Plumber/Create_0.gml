global.plumber_state = {
	// the current frame
	frame_index: 0,

	// -------------
	// -- physics --
	// -------------
	vx: 0,
	vy: 0,

	px: x,
	py: y,

	is_running: false,
	is_jump_held: false,
	is_on_ground: false,
	
	look_dir: 0,

	// -------------
	// -- drawing --
	// -------------
	anim_is_jumping: true,
	anim_move_frame: 0,
	anim_image_index: 0,

	// -----------
	// -- input --
	// -----------
	input_move: 0,
}

// -----------
// -- ivars --
// -----------
game = instance_nearest(0, 0, Game);

state = undefined

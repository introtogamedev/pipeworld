global.plumber_state = {
	
	// current frame
	frame_index: 0,

	// current velocity
	velocity_x: 0,
	velocity_y: 0,

	// the current position
	position_x: x,
	position_y: y,
	
	running: false,
	jump_held: false,
	on_ground: false,
	orientation: 0,

	// if we're in the jumping animation
	jumping_animation: true,

	// the current position in the move animation
	movement_frame: 0,

	// the current sprite index
	animation_index: 0,

	// the current input move dir
	input_move: 0,
	
	skidding: 0,
}

game = instance_nearest(0, 0, game_manager);
state = undefined;
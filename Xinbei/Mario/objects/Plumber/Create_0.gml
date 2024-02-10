// -----------
// -- state --
// -----------

// a state struct that contains all of the character data. we
// need this to be able to do save states & other nice features!

global.plumber_state = {
	// the current frame
	frame_index: 0,

	// -------------
	// -- physics --
	// -------------

	// the current velocity
	vx: 0,
	vy: 0,

	// the current position
	px: x,
	py: y,

	// if currently running
	is_running: false,

	// if the jump is currently held
	is_jump_held: false,

	// if we're colliding with the ground
	is_on_ground: false,

	// the current look direction
	look_dir: 0,

	// -------------
	// -- drawing --
	// -------------

	// if we're in the jumping animation
	anim_is_jumping: true,

	// the current position in the move animation
	anim_move_frame: 0,

	// the current sprite index
	anim_image_index: 0,

	// -----------
	// -- input --
	// -----------

	// the current input move dir
	input_move: 0,
}

// -----------
// -- ivars --
// -----------

// also known as "instance variables" or "props" or "properties",
// &c. they're data attached to an instance available across its
// other events like "step" and "draw"

// the game "manager", but we don't use that word
game = instance_nearest(0, 0, Game);

// the current state; we'll get this from the game every step
state = undefined
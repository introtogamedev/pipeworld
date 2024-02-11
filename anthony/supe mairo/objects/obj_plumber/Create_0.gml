//state template
global.plumber_state = {
	frame_index: 0,

	//horizontal velocity
	vx: 0,
	vy: 0,

	//position
	px: x,
	py: y,

	input_dir: 0,
	left: false,
	right: true,
	move: false,
	run: false,
	turn: false,

	//jump states
	jump_sprite: false,
	jumping: false,
	jumpable: true,
	on_floor: false,
	wall_kiss: false,
	jump_timer: 0

};

//ivars
state = undefined;
//global.plumber_state;

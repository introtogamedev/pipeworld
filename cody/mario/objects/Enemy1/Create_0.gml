global.enemy_state = {
	// physics
	vx: -1, // Initial velocity, assuming enemy moves left at start
	vy: 0,

	px: x,
	py: y,

	is_running: false,
	is_on_ground: false,
}

// ivars
game = instance_nearest(0, 0, Game);

state = undefined;

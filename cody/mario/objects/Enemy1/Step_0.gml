// constants for physics
#macro MOVE_SPEED -0.5 // Negative for left, positive for right

// get state
state = global.enemy_state;

// simple left-right movement
state.vx = MOVE_SPEED;

// gravity
state.vy += GRAVITY;

// integrate velocity
state.px += state.vx;
state.py += state.vy;

// Collision with the ground
var _is_on_ground = false;
var _py_collision = state.py + state.vy;
if (place_meeting(state.px, _py_collision, Level_Tiles)) {
	state.vy = 0;
	state.py = floor(state.py / 16) * 16; // Adjust to align to grid if using a 16x16 grid
	_is_on_ground = true;
} else {
	state.py += state.vy;
}

// Reverse direction upon hitting a wall
if (place_meeting(state.px + state.vx, state.py, Level_Tiles)) {
	state.vx *= -1; // Reverse direction
}

// Update global state
global.enemy_state.is_on_ground = _is_on_ground;
global.enemy_state.px = state.px;
global.enemy_state.py = state.py;
global.enemy_state.vx = state.vx;
global.enemy_state.vy = state.vy;

#macro MS 100000
//#macro FPS 60
#macro MOVE_SPEED 5
#macro MOVE_DECELERATION 4
#macro MOVE_ACCELERATION 6
#macro MOVE_RUN_ACCELERATION 12
#macro INPUT_LEFT ord("A")
#macro INPUT_RIGHT ord("D")
#macro INPUT_UP ord("W")
#macro INPUT_RUN vk_shift
#macro JUMP_IMPULSE 12  // Adjust this value as needed
#macro GRAVITY 0.3
#macro MAX_JUMP_FRAMES

	var _dt = delta_time / MS;

var _input_dir = 0;
var _input_dir_y = 0;
var is_on_ground = false;
var max_jump_height = 100;  // Adjust this value as needed
var jump_frames = 0;  // Initialize jump_frames


if keyboard_check(INPUT_LEFT) {
	_input_dir -= 1;
		image_speed = 3;
		
sprite_index = spr_mario_right;
	}

if keyboard_check(INPUT_RIGHT) {
	_input_dir += 1;
	image_speed = 3;
	sprite_index = spr_mario_right;
	}
	
if keyboard_check_pressed(INPUT_UP) && is_on_ground {
    // Jump initiation
    vy -= JUMP_IMPULSE;
	jump_frames = MAX_JUMP_FRAMES
    is_on_ground = false;
}

if (jump_frames > 0) {
	jump_frames--;
	vy -= GRAVITY * _dt;
	if (!keyboard_check(INPUT_UP)) {
		jump_frames = 0;
	}
}
	vy += GRAVITY *_dt;
	
		if (vx = 0) {
		image_speed = 0;
	}
	
	var _input_run = keyboard_check(INPUT_RUN);
	var _move_acceleration = MOVE_ACCELERATION;
	
	if (_input_run) {
		_move_acceleration = MOVE_RUN_ACCELERATION
	}
	
	var _ax = _move_acceleration * _input_dir;
	
	vx += _ax * _dt;
	
	if (vy > max_gravity) {
		vy = max_gravity;
	}
	
	if !_input_dir {
    var _deceleration = MOVE_DECELERATION * sign(vx);
    vx -= _deceleration * _dt;

    // Make sure vx doesn't go below zero to stop completely
    if (sign(vx) != sign(_deceleration)) {
        vx = 0;
    }
}
	
px += vx * _dt;
py += vy;
	/*
if (!tile_empty(floor(x), floor(y + sprite_height / 2))) {
    y = floor(y / 16) * 16 + 9.25// - sprite_height / 2;  // Adjust position to stay on the ground
    is_on_ground = true;
    vy = 0;  // Reset vertical velocity
} else {
    is_on_ground = false;
}
*/
var _px_collision = clamp(px, 0, room_width - sprite_width);
if (px != _px_collision) {
	px = _px_collision;
	vx = 0;
}

// check for ground collision
var _py_collision = py;

// get the bottom of the character
var _y1 = py + sprite_height;

// if it is colliding with a tile
if (level_collision(px, _y1) == TILES_BRICK) {
    // then move the player to the top of the tile    
   _py_collision -= (_y1 div 16) * 16 + 1;
}

// if we hit ground, move to the top of the block
if (py != _py_collision) {
	py = _py_collision;
	vy = 0;
}
show_debug_message("px: " + string(px) + ", _y1: " + string(_y1));

if (!_input_dir && is_on_ground) {
    var _deceleration = MOVE_DECELERATION * sign(vx);
    vx -= _deceleration * _dt;

    // Make sure vx doesn't go below zero to stop completely
    if (sign(vx) != sign(_deceleration)) {
        vx = 0;
    }
}
	
	if (x > 1500) {
		x = 1500;
	}
	
		if (x < 1) {
		x = 1;
	}
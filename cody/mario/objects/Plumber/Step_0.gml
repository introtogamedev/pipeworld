// -- constants --
#macro DT 0.01667
#macro MS 100000
#macro MOVE_ACCELERATION 1 / DT
#macro MAX_SPEED 10
#macro DECELERATION 0.01 / DT
#macro INPUT_LEFT vk_left
#macro INPUT_RIGHT vk_right

// Add in Create Event
max_speed = MAX_SPEED;
acceleration = MOVE_ACCELERATION;
deceleration = DECELERATION;

// -- step event --
var _input_dir = 0;
if (keyboard_check(INPUT_LEFT)){
    _input_dir -= 1;
}
if (keyboard_check(INPUT_RIGHT)){
    _input_dir += 1;
}

// Accelerate or decelerate
if (_input_dir != 0) {
    vx += acceleration * _input_dir;
    // Clamp velocity to max speed
    vx = clamp(vx, -max_speed, max_speed);
} else {
    // Apply deceleration
    if (vx > 0) {
        vx -= deceleration;
        if (vx < 0) vx = 0;
    } else if (vx < 0) {
        vx += deceleration;
        if (vx > 0) vx = 0;
    }
}

// Update position and ensure pixel perfect movement
var _dt = delta_time / MS;
x += round(vx * _dt);

// Prevent the plumber from leaving the room
x = clamp(x, 0, room_width - sprite_width);

// Update sprite facing direction
if (vx > 0) {
    // face right
	sprite_index = Plumber_Sprite_Right;
} else if (vx < 0) {
    // face left
    sprite_index = Plumber_Sprite_Left;
}

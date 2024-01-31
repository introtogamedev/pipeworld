vx = 0;
vy = 0;
px = x;
py = y;
look_dir = 0;

move_frame = 0;

image_idx = 0;

_input_dir = 0;

frame_index = 0;

//states
on_floor = false;
falling = false;
jumping = false;


//jump
jump_acceleration = 2;
jump_initial_impulse = 10;
jump_timer = 0;
jump_duration = 10;
jump_max_velocity = 15;

vertical_velocity = 0;
//falling
falling_max_velocity = 15;
//gravity
falling_gravity = 1;
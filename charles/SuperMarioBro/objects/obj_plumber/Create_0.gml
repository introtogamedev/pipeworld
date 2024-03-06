//velocities
vx = 0;
vy = 0;

//speed variables
spd = 3;
walking_spd = 1.5;
running_spd = 2.5;
turning_spd = 1.5;

//gravity
grav = 0;

//different gravity variables
up_grav = 7;
down_grav = 20;

//jump velocity
jump_vel = -4;

//maximum velocity
vx_max = 0;

//saves horizontal input as a constant
last_horizontal = 1;

//checks if it has horizontal input
horizontal_input = false;

//state
state = "is_idle";

//tilemap variable
ground_tiles = layer_tilemap_get_id("GroundTile");

//grounded variable
is_grounded = false;

frame = 0;

jump_timer = 0;

jump_min_height = 16;

jump_max_height = 64;

jump_height = jump_min_height;

hold_time = 0;

height_delta_per_frame = 2;

max_hold_time = 0.2;

can_jump = true;
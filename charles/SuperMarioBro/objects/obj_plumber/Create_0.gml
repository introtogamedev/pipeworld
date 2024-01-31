//velocities
vx = 0;
vy = 0;

//speed variables
spd = 3;
walking_spd = 2;
running_spd = 4;

//gravity
grav = 0;

//different gravity variables
up_grav = 7;
down_grav = 17;

//jump velocity
jump_vel = -4;

//maximum velocity
vx_max = 0;

//saves horizontal as a constant
last_horizontal = 1;

//checks if it has horizontal input
horizontal_input = false;

//state
state = "is_idle";

//tilemap variable
ground_tiles = layer_tilemap_get_id("GroundTile");

//grounded variable
is_grounded = false;



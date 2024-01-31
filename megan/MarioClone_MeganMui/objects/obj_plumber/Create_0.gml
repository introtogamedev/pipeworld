//Horizontal velocity
vx = 0;

//Vertical Velocity
vy = 0;

//Jumping Variables
jump_timer = 0;

//On Floor Variables
floor_timer = 0;

//game states
on_floor = false;
falling = false;
jumping = false;

//tilemap
tilemap_id = layer_tilemap_get_id("Floor");
tilemap = tilemap_get_at_pixel(tilemap_id, x, y + 5);















global.plumberstate = {

vx : 0,
vy : 0,
running : false,
max_speed : 6,
jumping : false,
on_ground : false,

tilemap : layer_tilemap_get_id("Tiles_1"),
rame_index : 0,

frame_index : 0,

// the current position
px : x,
py : y,

// the current look direction
look_dir : 0,

// the current position in the move animation
move_frame : 0,

// the current sprite index
image_idx : 0,

// the current input move dir
input_move : 0,
}

state = global.plumberstate;
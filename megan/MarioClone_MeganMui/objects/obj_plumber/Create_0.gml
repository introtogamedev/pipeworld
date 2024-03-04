state = {

frame_index: 0,

// the current velocity
vx: 0,
vy: 0,

// the current position
px: x,
py: y,

// the current look direction
look_dir: 0,
// the current position in the move animation
move_frame: 0,
// the current sprite index
image_idx: 0,
// the current input move dir
input_move: 0,

current_state: 0,

current_jump_height: 0,

move_drag: 4.5,
};

game =instance_nearest(0,0,obj_gm);

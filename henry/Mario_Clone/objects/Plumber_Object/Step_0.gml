if keyboard_check_pressed(vk_escape) {game_end()}

#region my bad but udnerstandable code
/*


#region calcualte horizontal movement


	if keyboard_check(ord("A")) {
		vx -= ACCEL;
		image_xscale = -1
	}

	if keyboard_check(ord("D")) {
		vx += ACCEL;
		image_xscale = 1
	}

	vx *= FRICTION;

	if keyboard_check(vk_shift) {vx *= 2;}



#endregion

#region jumping (help)

if keyboard_check_pressed(ord("W")){
	if !place_free(x, y+8){	
		vy += -6;
	}
}

vy += GRAVITY;

#endregion

#region collision with secret wall
if (place_meeting(x+vx+(.5*sign(vx)), y, Wall_Obj)){
	vx = 0;
}

if (place_meeting(x, y+vy+(.5*sign(vy)), Wall_Obj)){
	vy = 0;
}

//show_debug_message(velocity);

#endregion



#region actual movement

x += vx;
y += vy;

#endregion


*/
#endregion



#region ty's scary nightmare code

///*

#region constants

// constants
#macro FPS 60
#macro MS 1000000

//move constants

#macro MOVE_WALK_ACCEL 1.8 * FPS
#macro MOVE_RUN_ACCEL 3.6 * FPS
#macro MOVE_DECEL 1.2 * FPS

//input constants
#macro INPUT_LEFT ord("A")
#macro INPUT_RIGHT ord("D")
#macro INPUT_RUN vk_shift
#endregion

// find the input direction
var _input_dir = 0;

if keyboard_check(ord("A")) {_input_dir -= 1}
if keyboard_check(ord("D")) {_input_dir += 1}

var _input_run  = keyboard_check(INPUT_RUN);

// set the forces to 0 at the start of the frame
var _ax = 0;

var _move_accel = MOVE_WALK_ACCEL

if (_input_run) {
	_move_accel = MOVE_RUN_ACCEL;
}

_ax += _move_accel * _input_dir;


// get fractional delta time
var _dt = delta_time / MS;

//velocity: v = u + at
vx += _ax * _dt;

//add deceleration 
//Break down velocity into speed and direction
var _vx_mag = abs(vx);
var _vx_dir = sign(vx);

//apply deceleration if no input
var _dv = _ax * _dt;
if (_input_dir == 0) {
	_vx_mag -= MOVE_DECEL * _dt;
	_vx_mag = max (_vx_mag, 0);
}

//redo vx
vx = _vx_mag * _vx_dir; 

//position: p1 = p0 + vt
px += vx * _dt;

//collision
//stop character from moving through objects that it shouldn't
//including level boundary

//if we collide w/ lvl boundary, stop plumber
var _px_min = 0;
var _px_max = room_width - sprite_width;
var _px_collision = clamp(px, _px_min, _px_max);

//if we left the room, fix position and set velocity to 0
if px != _px_collision{
	px = _px_collision;
	vx = 0;
}

//update state
//if there is move input, face that direction
if (_input_dir !=0) {
	look_dir = _input_dir;
}

//capture the move state
imput_dir = _input_dir;

//update actual x
x = px;

//*/

#endregion





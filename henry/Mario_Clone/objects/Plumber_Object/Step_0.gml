if keyboard_check_pressed(vk_escape) {game_end()}


#region calcualte horizontal movement
///*

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


//*/

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

#region ty's scary nightmare code

/*

#region constants

// constants
#macro FPS 60
#macro MS 1000000

//move constants

#macro MOVE_WALK_ACCEL 1.2 * FPS

//input constants
#macro INPUT_LEFT ord("A")
#macro INPUT_RIGHT ord("D")
#endregion

// find the input direction
var _input_dir = 0;
if keyboard_check(ord("A")) {_input_dir -=1}

if keyboard_check(ord("D")) {_input_dir +=1}

// set the forces to 0 at the start of the frame
var _ax = 0;

_ax += MOVE_WALK_ACCEL * _input_dir


// get fractional delta time
var _dt = delta_time / MS;

//velocity: v = u + at
vx += _ax * _dt;

//position: p1 = p0 + vt
px += vx * _dt;

//update actual x
x = px;

*/

#endregion





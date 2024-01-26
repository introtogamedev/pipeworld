/// -- constants --

//seconds per frame
#macro DT 0.016667
//microseconds per second
#macro MS 1000000

#macro MOVE_ACCELERATION 0.1 / DT
#macro INPUT_LEFT ord("A")
#macro INPUT_RIGHT ord("D")
#macro INPUT_RUN vk_shift

/// -- movement --

var _input_dir = 0;
if (keyboard_check(INPUT_LEFT)) {
	_input_dir--;
}

if (keyboard_check(INPUT_RIGHT)) {
	_input_dir++;
}


var _ax = MOVE_ACCELERATION * _input_dir;

var _dt = delta_time / MS;

//Check if running or not

if (keyboard_check(INPUT_RUN)) {
	vx += 2 * _ax * _dt;
} else {
	vx += _ax * _dt;
}

dir_x = sign(vx);

vx -= sign(vx) * 0.05

if (dir_x != sign(vx)) {
	vx = 0;
}



if (keyboard_check(INPUT_RUN)) {
	if (abs(vx) > max_vx * 2) {
		vx = sign(vx) * max_vx * 2;
	}
} else if (abs(vx) > max_vx) {
	vx = sign(vx) * max_vx;
}



x += vx;

/// -- keep on screen --

if (x < 0 - sprite_width / 2) {
	x = - sprite_width / 2;
} else if (x > room_width - sprite_width / 2) {
	x = room_width - sprite_width / 2;
}
//constants
//the number of seconds in a normal frame

#macro FPS 60
#macro MS 1000000
#macro MOVE_ACCELERATION 6
#macro Stop_acceleration 6

//run
#macro MOVE_WALK_ACCELERATION 1.8 * FPS
#macro MOVE_RUN_ACCELERATION 4.2 * FPS
#macro MOVE_DECELERATION 1.2 * FPS
#macro JUMP_GRAVITY 16 * FPS

// input
#macro INPUT_UP ord ("W")
#macro INPUT_LEFT ord ("A")
#macro INPUT_RIGHT ord ("D")

//room boundary
if (x + sprite_width /2 > room_width) {
	x = room_width - sprite_width / 2;
}

if (x < sprite_width/2) {
	x = 0 + sprite_width / 2;
}

//step
var _input_dir = 0;
var press_left = false;
var press_right = false;
var press_up = false;
var _avx = vx;


if (keyboard_check(INPUT_LEFT) && x > 0 + sprite_width / 2){
	_input_dir -= 1;
	press_left = true;
	image_xscale = -1;
	}
	
	
if (keyboard_check(INPUT_RIGHT) && x + sprite_width / 2 < room_width){
	_input_dir += 1;
	press_right = true;
	image_xscale = 1;
}


//abs() 用来calculate绝对值
// eg.  var _vx_mag = abs (vx);
//sign() 用来还原任何变量的原数，eg绝对值前这个值是正是负
//eg.   var _vx_dir = sign(vx);


//friction: stop
if (press_left == false && press_right == false && press_up == false) {
	if (vx < 0) { 
	    _avx *= -1;
		_avx -= Stop_acceleration;
		if (_avx < 0) _avx = 0;
		vx = _avx * -1;
	} else {	
		_avx -= Stop_acceleration;
		if (_avx < 0){
			_avx = 0;
		}
		vx = _avx;		
	}	
}
	

//find the move acceleration
var _ax = MOVE_ACCELERATION * _input_dir;

//get fractoional deltatime
var _dt = delta_time / MS;

//vx(speed)integrate acceleration into velocity
vx += _ax * _dt;



var TILES_BRICK = layer_tilemap_get_id("Tiles_1")

//vertical collision
if (place_meeting (x, y+vertical_velocity, TILES_BRICK)){
	while (abs(vertical_velocity)>0.1){
		vertical_velocity/=2;
		if (!place_meeting (x, y+vertical_velocity, TILES_BRICK)){
			y+=vertical_velocity;
		}
	}
	vertical_velocity = 0;
}

// horizontal collision
if (place_meeting(x + vx, y, TILES_BRICK)){
    while (abs(vx) > 0.1){
        vx /= 2;
        if (!place_meeting(x + vx, y, TILES_BRICK)){
            x += vx;
        }
    }
    vx = 0;
}

//jump

if (!jumping && !place_meeting (x, y + sprite_height / 2, TILES_BRICK)) falling = true;

if (falling)
{
	vertical_velocity += falling_gravity;
	if (vertical_velocity > falling_max_velocity) 
	{
		vertical_velocity = falling_max_velocity;
	}
	
	//var vertical_check = 10;
	if (place_meeting (x, y+3, TILES_BRICK))
	{
		vertical_velocity = 0;
		//var floor_instance = instance_place (x, y + vertical_check, TILES_BRICK);
		falling = false;
		on_floor = true;
	}
}


if (on_floor)
{
	if (keyboard_check_pressed(INPUT_UP))
	{
		on_floor = false;
		jumping = true;
		press_up = true;
		
		vertical_velocity -= jump_initial_impulse;
	}
}


if (jumping)
{
	if (keyboard_check(INPUT_UP))
	{
		vertical_velocity -= jump_acceleration;
	}
	else jumping = false;
	
	if (vertical_velocity < -jump_max_velocity)
	{
		vertical_velocity = -jump_max_velocity;
	}
	jump_timer++;
	
	if (jump_timer > jump_duration)
	{
		jumping = false;
		jump_timer = 0;
	}
}


//sound effects
if keyboard_check_pressed(INPUT_UP)
{
	audio_play_sound(snd_mario_jump, 10, false);
}


// Animation
	//jump animation
if (jumping == true)
{
	image_speed = 2;
	sprite_index = spr_plumber_jump;
}

if (on_floor == true)
{
	sprite_index = spr_plumber_sprite;
}
	
//Moving
    if (vx != 0) {
        image_speed = 4;
    } else {
        // Standing still
        image_speed = 0;
		if (_input_dir < 0 && jumping = false)
		{
			image_speed = 0;
			image_xscale = -1;
		}
		if (_input_dir > 0 && jumping = false)
		{
			image_speed = 0;
			image_xscale = 1;
			}
	image_index = 0;
	}
	


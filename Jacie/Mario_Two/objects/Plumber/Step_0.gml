
//The number of seconds in a normal frame
#macro FPS 60

//The number of microseconds in a second
#macro MS 1000000

#macro MOVE_ACCELERATION 1.8 *FPS
#macro MOVE_RUN_ACCELERATION 3.6 * FPS
#macro MOVE_DECELERATION 1.2 * FPS
#macro INPUT_LEFT ord("A")
#macro INPUT_RIGHT ord("D")
#macro INPUT_RUN (vk_shift)

#macro JUMP_GRAVITY .2 * FPS


//grav
var ay = 0;
ay = JUMP_GRAVITY;

//Movement
//Find the input direction
var input_run = keyboard_check(INPUT_RUN);

var input_dir = 0;

if (keyboard_check(INPUT_LEFT)){input_dir -= 1;}
if (keyboard_check(INPUT_RIGHT)){input_dir += 1;}
	

var move_accel = MOVE_ACCELERATION;

//Get the move acceleration
var ax = 0;
if (keyboard_check(INPUT_RUN))
{
    move_accel = MOVE_RUN_ACCELERATION;
}

ax += move_accel * input_dir;

//get fractional delta time
var dt = delta_time / MS;

//Integrate acceleration into velocity
vx += ax * dt;
vy += ay * dt;

//break down velocity into speed and direction
var _vx_mag = abs(vx);
var _vx_dir = sign(vx);

//if apply deceleration if their is no player input
if (input_dir == 0)
	{
		_vx_mag -= MOVE_DECELERATION * dt
		_vx_mag = max(_vx_mag,0);
	}

vx = _vx_mag * _vx_dir;

px += vx * dt;
py += vy * dt;

//Integrate velocity into position
var dx = vx * dt;


//room bounds collision
var px_min = 0;
var px_max = room_width - sprite_width;
var px_collision = clamp(px, px_min, px_max)

if (px != px_collision)
	{
		px = px_collision;
		vx = 0;
	}

//ground collision
/*
var _y1 = py + sprite_height;

var py_collision = py;
if (level_collision(px,_y1) == !tile_get_empty())
{
	py_collision -= py % 16;
}
//move top of block
if (py != py_collision)
	{
		py = py_collision;
		vy = 0;
	}
else {
}
*/
_input_dir = input_dir;
if (_input_dir != 0)
	{
		look_dir = input_dir;
	}
	
x = px;
y += vy;



//when hit floor
if (!jumping && !level_collision(floor(x),floor(y + sprite_height)))
	{
		falling = true;
	}
	
//falling
if (falling)
	{
	vertical_velocity += falling_gravity;

//cap vertical velocity as max
	if (vertical_velocity > falling_max_velocity) 
		{
			vertical_velocity = falling_max_velocity;
		}
var vertical_check = 5;
//meet floor
	if (!level_collision(floor(x),floor(y + sprite_height)))
		{
			y = y - y % 16 +sprite_height /2;
			vy = 0;
		
			py = floor(y);}	
			vertical_velocity = 0;
			falling = false;
			on_floor = true;
		}
		
//jump

//on floor
if (on_floor)
	{
//jump 1
		if (keyboard_check_pressed(ord("1")))
			{
				on_floor = false;
				jumping = true;
//burst of speed
				vertical_velocity -= jump_initial_impulse;
		
			}
	}
// jump	state
if (jumping)
	{
//jump 1
		if (keyboard_check(ord("1")))
			{
				vertical_velocity -= jump_acceleration;
//max jump
		if (vertical_velocity < -jump_max_velocity) 
			{
				vertical_velocity = -jump_max_velocity;
			}
		jump_timer ++;
		
		if (jump_timer > jump_duration)
			{
				jumping = false;
				jump_timer = 0;
			}
				
			}
	}

if (!keyboard_check(ord("1")))
	{
		jumping = false;
	}
		


	
frame_index +=1;

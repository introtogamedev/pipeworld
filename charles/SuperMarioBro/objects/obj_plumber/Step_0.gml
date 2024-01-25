var _dt = delta_time/1000000;
var _move_acc = 0.1 * fps;
var _decc = 0.002 * fps;

var _rightkey = keyboard_check(vk_right);
var _leftkey = keyboard_check(vk_left);
var _jump = keyboard_check_pressed(ord("X"));
var _run = keyboard_check(ord("Z"));

var _horizontal = _rightkey - _leftkey;

if(_horizontal != 0)
{
	last_horizontal = _horizontal;
}

if(!_rightkey && !_leftkey)
{
	horizontal_input = false;
}
else
{
	horizontal_input = true;
}

if(_jump)
{
	vy = jump_vel;
}

if(horizontal_input)
{
	var _acc_x = _move_acc  * last_horizontal;
	vx += _acc_x * _dt;
	
	if(_run)
	{
		state = "is_run";
	}
	else
	{
		state = "is_walking";
	}
	
	if(sign(last_horizontal) != sign(vx) && state != "is_idle")
	{
		state = "is_turning";
	}
	
}
else
{
	if(last_horizontal > 0)
	{
		if(vx > 0)
		{
			vx -= _decc;
		}
		else
		{
			vx = 0;
		}
	}
	else
	{
		if(vx < 0)
		{
			vx += _decc;
		}
		else
		{
			vx = 0;
		}
	}
	
	if(vx == 0)
	{
		state = "is_idle";
	}
}

vy += grav * _dt;

vx = clamp(vx, -vx_max, vx_max);
 
x += vx;
y += vy;

image_xscale = sign(last_horizontal);

switch(state)
{
	case "is_idle":
		image_speed = 1;
		sprite_index = spr_mario_idle;
		vx_max = walking_spd;
	break;
	case "is_walking":
		image_speed = 1;
		sprite_index = spr_mario_walking;
		vx_max = walking_spd;
	break;
	case "is_run":
		image_speed = 2;
		sprite_index = spr_mario_walking;
		vx_max = running_spd;
	break;
	case "is_turning":
		image_speed = 1;
		sprite_index = spr_mario_turning;
	break;
}

if(x <= sprite_width/2 || x >= room_width - sprite_width/2)
{
	vx = 0;
}
if(y < 0 || y >= room_height - sprite_height)
{
	vy = 0;
}

x = clamp(x, sprite_width/2, room_width - sprite_width/2);
y = clamp(y, 0, room_height - sprite_height);

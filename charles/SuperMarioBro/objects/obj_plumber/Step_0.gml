var _dt = delta_time/1000000;

var _rightkey = keyboard_check(vk_right);
var _leftkey = keyboard_check(vk_left);
var _jump = keyboard_check(ord("X"));

var _horizontal = _rightkey - _leftkey;
if(_jump)
{
	vy = jump_vel;
}

var _acc_x = move_acc * _horizontal;

vx += _acc_x * _dt;
vy += grav * _dt;

x += vx;
y += vy;
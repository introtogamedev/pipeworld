var _rightkey = keyboard_check(vk_right);
var _leftkey = keyboard_check(vk_left);
var _jump = keyboard_check(vk_space);

var _horizontal = _rightkey - _leftkey;
if(_jump)
{
	yspd = jump_vel;
}


xspd = spd *_horizontal;
yspd += grav;

x += xspd;
y += yspd;





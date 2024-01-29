key_up = keyboard_check(ord("w"));
key_down = keyboard_check(ord("S"));
key_left = keyboard_check(ord("A"));
key_right = keyboard_check(ord("D"));

var hMove = key_right - key_left;

if (hMove != 0)
{
	if (last_h != hMove)
	{
		last_h = hMove;
		final_acceleration = 0;
	}
	if (final_acceleration <= max_speed)
	{
		final_acceleration += acceleration;
	}
}
else
{
	if(final_acceleration > 0)
	{
		final_acceleration-= acceleration;
	}
}

if (final_acceleration < acceleration)
{
	final_acceleration = 0;
	last_h = 0;
}
hsp = final_acceleration * last_h;

if(hsp = 0)
{
	image_speed = 0;
	image_index = 0;
}
else
{
	image_speed = 0.4;
}

x+=hsp;
y+=vsp;

if (x < 5)
{
    x = 5;
}
if (x > 250)
{
    x = 250;
}

if (keyboard_check(ord("A")))
{
	image_xscale = -1;
}
if (keyboard_check(ord("D")))
{
	image_xscale = 1;
}


key_up = keyboard_check(ord("w"));
key_down = keyboard_check(ord("S"));
key_left = keyboard_check(ord("A"));
key_right = keyboard_check(ord("D"));

move = key_right - key_left;
//Move Right
if (move == 1)
{
	hsp += acc;
	if (hsp >= maxSpeed)
	{
		hsp = maxSpeed;
	}
}
else if (hsp > 0)
{
	hsp -= acc;
	if (hsp <= 0)
	{
		hsp = 0;
	}
}


//Move Left
if (move == -1)
{
	hsp -= acc;
	if (hsp <= -maxSpeed)
	{
		hsp = -maxSpeed;
	}
}
else if (hsp < 0)
{
	hsp += acc;
	if (hsp >= 0)
	{
		hsp = 0;
	}
}

// Jumping
if (place_meeting(x, y + 1, obj_wall) && keyboard_check_pressed(ord("W")))
{
    vsp = -jumpSpeed;
}

// Gravity
vsp += grav;

// Horizontal collision
if (place_meeting(x + hsp, y, obj_wall))
{
    while (!place_meeting(x + sign(hsp), y, obj_wall))
    {
        x += sign(hsp);
    }
    hsp = 0;
}

// Vertical collision
if (place_meeting(x, y + vsp, obj_wall))
{
    while (!place_meeting(x, y + sign(vsp), obj_wall))
    {
        y += sign(vsp);
    }
    vsp = 0;
}

// Update position
x += hsp;
y += vsp;

if (x < 5)
    x = 5;
if (x > room_width - 5)
    x = room_width - 5;
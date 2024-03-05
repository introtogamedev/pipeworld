key_up = keyboard_check(ord("w"));
key_down = keyboard_check(ord("S"));
key_left = keyboard_check(ord("A"));
key_right = keyboard_check(ord("D"));

move = key_right - key_left;

//Animation

if (vsp != 0)
{
	sprite_index = spr_mario_jump;
}
else if (hsp == 0)
{
	sprite_index = spr_mario_idle;
}
else if (abs(hsp) > 0)
{
	sprite_index = spr_mario_run;
}

//Move Right
if (move == 1)
{
	hsp += acc;
	if (hsp >= maxSpeed)
	{
		hsp = maxSpeed;
	}
	image_xscale = 1;
}
else if (hsp > 0)
{
	hsp -= acc;
	if (hsp <= 0)
	{
		hsp = 0;
	}
	image_xscale = 1;
}


//Move Left
if (move == -1)
{
	hsp -= acc;
	if (hsp <= -maxSpeed)
	{
		hsp = -maxSpeed;
	}
	image_xscale = -1;
}
else if (hsp < 0)
{
	hsp += acc;
	if (hsp >= 0)
	{
		hsp = 0;
	}
	image_xscale = -1;
}

// Jumping
if (place_meeting(x, y + 1, obj_wall) && keyboard_check_pressed(ord("W")))
{
    vsp = -jumpSpeed;
	audio_play_sound(mario_jump_sound,0,false);
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
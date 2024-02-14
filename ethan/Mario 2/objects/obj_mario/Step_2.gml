/// @description Insert description here
// You can write your code in this editor

//Bottom right
var x2 = x + sprite_width;
var y2 = y + sprite_height;

//Collisions
//From Bottom
if (!Level_Collision(floor(x+3),floor(y+3)) || !Level_Collision(floor(x2-4), floor(y+3)))
{
	show_debug_message("Hit a ceiling block");
	y = y + 2;
	vy = 0;
	py = floor(y);
}

//From Left
if (!Level_Collision(floor(x2-2),floor(y+3)) || !Level_Collision(floor(x2-2), floor(y2-3)))
{
	show_debug_message("Hit a block from the left");
	x = x - vx;
	px = floor(x);
}

//From Right
if (!Level_Collision(floor(x+1),floor(y+3)) || !Level_Collision(floor(x+1), floor(y2-3)))
{
	show_debug_message("Hit a block from the right");
	x = x - vx;
	px = floor(x);
}

//Top Collision
if (!Level_Collision(floor(x+3),floor(y2)) || !Level_Collision(floor(x2-4), floor(y2)))
{
	show_debug_message("On a block");
	y = y - y % 16 //- sprite_height;
	vy = 0;
	py = floor(y);
	on_floor = true;
	jumping = false;
	jump_time = 8;
} else {
	on_floor = false;
}

//Jumping
if (keyboard_check(INPUT_JUMP))
{
	//Player allowed to determine jump height
	if (jump_time > 0)
	{
		vy = jump_velocity;
		jump_time--;
	}
	
	if (on_floor) 
	{
		on_floor = false;
		jumping = true;
	}
}
if (keyboard_check_released(INPUT_JUMP))
{
	jump_time = 0;
}

if (jumping)
{
	if (sprite_index = spr_marioleft)
	{
		sprite_index = spr_mariojump;
		image_index = 1;
	} 
	if (sprite_index = spr_marioright) 
	{
		sprite_index = spr_mariojump;
		image_index = 0;
	}
}

//Reset the sprite once hitting floor after jump
if (on_floor && sprite_index = spr_mariojump)
{
	if (image_index = 1) sprite_index = spr_marioleft;
	if (image_index = 0) sprite_index = spr_marioright;
}

//Image Speed
if (vx < 0 || vx > 0 && !jumping)
{
	image_speed = 1;
}
else if (vx == 0 && !jumping)
{
	image_speed = 0;
	image_index = 0;
}
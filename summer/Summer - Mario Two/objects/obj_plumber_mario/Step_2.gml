//pause game
if (pause_game == true)
{
	return;
}


//integrate velocity into position
y += vertical_velocity;
x += vx;


//room boundary
if (x + sprite_width /2 > room_width) {
	x = room_width - sprite_width / 2;
	}


if (x < 8) {
	x = 8;
}


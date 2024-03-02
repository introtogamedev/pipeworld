/// -- pause check --

if (paused) {
	if (frame_skip != 1) {
		return;
	}
}


//Change the x with both sides collision

x += vx;


//show_debug_message(move_dir);

/// -- keep on screen --

if (x < sprite_side_width) {
	x = sprite_side_width;
	vx = 0;
} else if (x > room_width - sprite_side_width) {
	x = room_width - sprite_side_width;
	vx = 0;
}



/// -- collision --


if (!tile_empty(x + (sprite_side_width-1) * move_dir ,y)) {
    while (!tile_empty(x + (sprite_side_width-1) * move_dir,y)) {
		//show_debug_message(string(x+vx +sprite_width / 2 ) + " is subtracted by " + string(-sign(vx)) + " x is " + string(x) );
        x -= move_dir;
    }
	//show_debug_message("x check worked");
	//x = floor(x); //stops a weird stuttering
	vx = 0;
	//show_debug_message("x is " + string(x) + " rounded is " +string(floor(x)));
}

//show_debug_message("first_check");
if (!tile_empty(x - (sprite_side_width-1) * move_dir ,y)) {
    while (!tile_empty(x - (sprite_side_width-1) * move_dir,y)) {
		//show_debug_message(string(x+vx +sprite_width / 2 ) + " is subtracted by " + string(-sign(vx)) + " x is " + string(x) );
        x += move_dir;
    }
	//show_debug_message("x check worked");
	//x = floor(x); //stops a weird stuttering
	vx = 0;
	//show_debug_message("x is " + string(x) + " rounded is " +string(floor(x)));
}
//show_debug_message("second_check");
show_debug_message(vx);

//Change the y with top collision

y += vy

if (((!tile_empty(x +1 - sprite_width / 2,y - sprite_height / 2)) || (!tile_empty(x -1 + sprite_width / 2,y - sprite_height / 2))) && vy < 0) {
	//show_debug_message("y start");
    while ((!tile_empty(x +1 - sprite_width / 2,y-sprite_height/2)) || (!tile_empty(x -1 + sprite_width / 2,y-sprite_height/2))) {
        y++;
		//show_debug_message(y);
		//show_debug_message(move_dir);
    }
	//show_debug_message("y check worked");
	vy = 0;
	jump_frames = 0;
}
//show_debug_message("y_check");

//show_debug_message(y);
//show_debug_message(vy);


//Check for floor collision

if (((!tile_empty(x+1 - sprite_width/2,y + sprite_height / 2)) || (!tile_empty(x-1 + sprite_width/2,y + sprite_height / 2))) && vy >= 0) {
	y = y - y % 16 + sprite_height / 2;
	vy = 0;
	on_ground = true;
} else {
	on_ground = false;
}

//show_debug_message("y_check2");



//show_debug_message("step mid " +string(x));


//show_debug_message("step end " +string(x));

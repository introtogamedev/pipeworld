 //sprite position shift
var xdisplay = floor(x);
var ydisplay = floor(y);
//sprite direction
image_xscale = facing_dir;

image_xscale = facing_dir;
image_xscale = facing_dir;

#region sprite assignment
//RUNNING
if (plumberAnimation.xmoving){
	if (runActivate){
			sprite_index = spr_marioSPEEDRUN
	}else{
	sprite_index = spr_marioRUN;
	}
}else{
	sprite_index = spr_marioIDLE;
}

if (plumberAnimation.turning){
	sprite_index = spr_marioSKID
}
if (skidding){
	sprite_index = spr_marioSKID
}

//JUMPING (overrides running sprites)
if (plumberAnimation.jumping){
	sprite_index = spr_marioJUMP;
}else if (not onGround){
	image_speed = 0;//pause animation based on current frame
}else{
	image_speed = 1; //resume animation 
}

#endregion

#region DEBUGGING OVERRIDE
if (DEBUG_MODE){
	if (pause){
		image_speed = 0;
		if (tempframe){
			image_index ++;
		}
	}else{
		image_speed = 1;
	}
}
#endregion

draw_sprite_ext(
	sprite_index,
	image_index,
	xdisplay, ydisplay, 
	image_xscale, 
	image_yscale,
	image_angle, 
	image_blend,
	image_alpha)
	
#region debugging visuals
if (DEBUG_MODE){
	draw_rectangle(x - sprite_width/2, y - sprite_height , x + sprite_width/2, y, true);
}
#endregion
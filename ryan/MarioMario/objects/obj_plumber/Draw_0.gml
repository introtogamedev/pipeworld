//sprite position shift
var xdisplay = floor(x);

//sprite direction
image_xscale = facing_dir;

#region sprite assignment

//RUNNING
if (abs(xvelocity) >= SPR_SPEEDRUN_TRIGGER){
	sprite_index = spr_marioSPEEDRUN;
}else if (abs(xvelocity) == 0){
	sprite_index = spr_marioIDLE;
}else if (abs(xvelocity) < SPR_RUN_TRIGGER){
	sprite_index = spr_marioRUN;
}

#endregion

draw_sprite_ext(
	sprite_index,
	image_index,
	xdisplay, y, 
	image_xscale, 
	image_yscale,
	image_angle, 
	image_blend,
	image_alpha)
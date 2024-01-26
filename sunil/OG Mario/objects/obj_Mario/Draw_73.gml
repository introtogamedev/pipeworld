//

if (abs(vx) > 0) {
	sprite_index = spr_runningMario;
} else {
	sprite_index = spr_idleMario;
}


if (vx > 0) {
	image_xscale = 1;
} else if (vx < 0) {
	image_xscale = -1;
}
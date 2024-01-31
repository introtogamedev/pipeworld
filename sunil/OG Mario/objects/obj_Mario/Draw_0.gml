#macro RUN_ANIM_START 1
#macro RUN_ANIM_LENGTH 3
#macro ANIM_SPEED 1/7


if (vx != 0) { //change thise
	anim_frame = (anim_frame + ANIM_SPEED) % RUN_ANIM_LENGTH;
	spr_frame = RUN_ANIM_START + anim_frame;
} else {
	spr_frame = 0;
}

if (!on_floor) {
	spr_frame = 4;
}

if (vx > 0) { //chagne this
	image_xscale = 1;
} else if (vx < 0) {
	image_xscale = -1;
} 

draw_sprite_ext(
	sprite_index,
	spr_frame,
	floor(x),
	floor(y),
	image_xscale,
	image_yscale,
	image_angle,
	image_blend,
	image_alpha
);
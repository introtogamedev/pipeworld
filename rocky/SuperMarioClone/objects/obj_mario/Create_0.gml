/// @description Insert description here
// You can write your code in this editor
test_left=0;
//movement
normSpeed=80;
sprintSpeed=160;
maxSpeed=normSpeed;

g=800;

//jump
jump_height_min=1<<4;//1 4
jump_height_max=4<<4;
jump_acceleration=sqrt((g*jump_height_min)<<1);
max_jump_press_time=(jump_height_max-jump_height_min)/jump_acceleration;
jump_press_time=0;
can_jump=true;


velocityx=0
velocityy=0;
accelerationx=0;
accelerationy=0;

camera=view_camera[0];
view_width=camera_get_view_width(camera);
view_height=camera_get_view_height(camera);

offset=0;

tilemap=layer_tilemap_get_id("Tiles_1");

clipping=0;
isFalling=false;
/*
function CheckTileCollisionY(){
	return place_meeting(x,y,tilemap);
	tile=levelCollision(x,y+(sign(velocityy)<<4),tilemap);
	if(tile<=0)
		return false;
	top=y-(abs(sprite_height)>>1);
	bottom=top+abs(sprite_height);
	t=((y+(sign(velocityy)<<4))>>4)<<4;
	b=t+16;
	//show_debug_message(string(left)+","+string(right)+","+string(top)+","+string(bottom)+"|"+string(l)+","+string(r)+","+string(t)+","+string(b));
	return ((t>=top and t<=bottom) or (b>=top and b<=bottom));
}
function CheckTileCollisionX(){
	return place_meeting(x,y,tilemap);
	tile=levelCollision(x+(sign(velocityx)<<4),y, tilemap);
	if(tile<=0)
		return false;
	left=x-(abs(sprite_width)>>1);
	right=left+abs(sprite_width);
	l=(((x+(sign(velocityx)<<4))>>4)<<4);
	r=l+16;
	//show_debug_message("tile="+string(tile)+", "+string(left)+","+string(right)+"|"+string(l)+","+string(r));
	return ((l>=left and l<=right) or (r>=left and r<=right));
}*/
#region animation
//idle, walk, jump, skid
idle={
	nom:"idle",
	clip_id: spr_mario_idle
};
walk={
	nom:"walk",
	clip_id: spr_mario_walk
};
skid={
	nom:"skid",
	clip_id: spr_mario_skid
};
jump={
	nom:"jump",
	clip_id: spr_mario_jump
};

animator={
	cur_clip:walk,
	play:function(clip){
		if(clip!=cur_clip){
			cur_clip=clip;
			obj_mario.sprite_index=cur_clip.clip_id;
		}
	}
};
#endregion
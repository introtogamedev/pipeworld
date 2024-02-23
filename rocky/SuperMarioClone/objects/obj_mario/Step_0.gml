#macro ACCELERATION 180
#macro ACCELERATION_RUN 240
#macro ACCELERATION_SKID 800
#macro DECCELERATION 220
#macro KEY_LEFT ord("A")
#macro KEY_RIGHT ord("D")
#macro SPRITE_LEN 16
#macro SPRITE_LEN_HALF 8
#macro COLLISION_OFFSET 7

//show_debug_message(string(global.state.x)+","+string(global.state.y));
dt=delta_time/1000000;
if(dt<0.05){
if(!global._pause){
//----------------
//----movement----
//----------------
global.state.ax=0;
global.state.ay=0;
//	horizontal
if(keyboard_check(KEY_LEFT) and global.state.vx>-maxSpeed){
	if(global.state.vx>0)
		global.state.ax-=ACCELERATION_SKID;
	else
		global.state.ax-=(keyboard_check(vk_shift)?ACCELERATION_RUN:ACCELERATION);
	global.state.look_direction=1;
}
else if(keyboard_check(KEY_RIGHT) and global.state.vx<maxSpeed){
	if(global.state.vx<0)
		global.state.ax+=ACCELERATION_SKID;
	else
		global.state.ax+=(keyboard_check(vk_shift)?ACCELERATION_RUN:ACCELERATION);
	global.state.look_direction=-1;
}
else{
	acc=sign(global.state.vx)*DECCELERATION*dt;
	if(abs(acc)>abs(global.state.vx))
		global.state.vx=0;
	//if(abs(global.state.vx)<1)
		//global.state.vx=0;
	else{
		//global.state.ax-=sign(global.state.vx)*DECCELERATION;
		global.state.vx-=acc;
	}
}

if(keyboard_check_pressed(vk_shift)){
	maxSpeed=sprintSpeed;
}
else if(keyboard_check_released(vk_shift)){
	maxSpeed=normSpeed;
}
//-------------
//----jump-----
//-------------
if(global.state.can_jump and keyboard_check_pressed(ord("W")) and global.state.vy<40){
	global.state.vy=-jump_acceleration;
	animator.play(jump);
	global.state.can_jump=false;
	global.state.jump_press_time=0;
	audio_play_sound(snd_jump,1,false);
}
if(global.state.jump_press_time<max_jump_press_time&&!global.state.isFalling&&keyboard_check(ord("W"))){
	global.state.jump_press_time+=dt;
	global.state.vy=-jump_acceleration;
}
if(keyboard_check_released(ord("W")))
	global.state.jump_press_time=1000000;
	
//----gravity----
global.state.ay+=g;

//-----------------
//-velocity update-
//-----------------
//----collision----
//-----------------
global.state.vx+=global.state.ax*dt;
global.state.vy+=global.state.ay*dt;
global.state.x+=global.state.vx*dt;
if(place_meeting(global.state.x,global.state.y,tilemap)){
	if(global.state.clipping!=0){
		//show_debug_message("1");
		global.state.x-=global.state.vx*dt;
		//global.state.x+=global.state.clipping*((global.state.x&15)+global.state.clipping*8)*(dt*7);
		global.state.x+=global.state.clipping*((global.state.x&15))*(dt*7);
		
		global.state.vx=0;
		global.state.ax=0;
	}
	else{
		global.state.x&=~15;
		global.state.x+=SPRITE_LEN_HALF;
		global.state.vx=0;
		global.state.ax=0;
	}
}
global.state.y+=global.state.vy*dt;
if(place_meeting(global.state.x,global.state.y,tilemap)){
	if(global.state.vy>0){ /////////-------------on landing (from jump)---------------
		global.state.can_jump=true;
		global.state.isFalling=false;
		global.state.y&=~15;
		global.state.y+=SPRITE_LEN_HALF;
		global.state.vy=0;
		global.state.clipping=0;
	}
	else if(global.state.vy<0){
		if(levelCollision(global.state.x,global.state.y-16,tilemap)==0){//--------------clips through the edge----------
			if((global.state.x&15)<SPRITE_LEN_HALF and (global.state.x&15)>(SPRITE_LEN_HALF-COLLISION_OFFSET) and global.state.vx<=0){//on the right
				global.state.clipping=1;
			}
			else if((global.state.x&15)>SPRITE_LEN_HALF and (global.state.x&15)<SPRITE_LEN_HALF+COLLISION_OFFSET and global.state.vx>=0){//on the left
				global.state.clipping=-1;
			}//-------------------------------------------------------------------------------
			else{
				global.state.isFalling=true;
				global.state.jump_press_time=1000000;
				global.state.clipping=0;
				global.state.y&=~15;
				global.state.y+=SPRITE_LEN_HALF;
				global.state.vy=0;
			}
		}
		else{
			global.state.isFalling=true;
			global.state.jump_press_time=1000000;
			global.state.clipping=0;
			global.state.y&=~15;
			global.state.y+=SPRITE_LEN_HALF;
			global.state.vy=0;
		}
	}
	else{
		global.state.isFalling=true;
		global.state.jump_press_time=1000000;
		global.state.y&=~15;
		global.state.y+=SPRITE_LEN_HALF;
		global.state.vy=0;
		global.state.clipping=0;
	}
}


//-----------------
//-----scaling-----
//-----------------
if(global.state.vx>0)
	global.state.xscale=-1;
else if(global.state.vx<0)
	global.state.xscale=1;
else
	global.state.xscale=global.state.look_direction;
/*
if(global.state.vx==0){
	if(global.state.ax==0)
		global.state.xscale=keyboard_check(KEY_LEFT)?-1:1;
	else
		global.state.xscale=global.state.ax>=0?1:-1;
}
else
	global.state.xscale=global.state.vx>=0?1:-1;
*/
//------------------------------
//-cannot move outside the room-
//------------------------------

left=camera_get_view_x(camera)+SPRITE_LEN_HALF;
right=left+view_width-abs(sprite_width);
up=camera_get_view_y(camera)+SPRITE_LEN_HALF;
down=up+view_height-abs(sprite_height);
if(left>global.state.x){
	global.state.x=left;
	global.state.vx=0;
}
else if(right<global.state.x){
	global.state.x=right;
	global.state.vx=0;
}
if(down<global.state.y){
	global.state.y=down;
	global.state.vy=0;
}
else if(up>global.state.y){
	global.state.y=up;
	global.state.vy=0;
}
//----------------------
//-----set viewport-----
//----------------------
xdif=global.state.x-left-(view_width>>1);
if(xdif>0){
	//camera_get_view_x(camera)+xdif
	camera_set_view_pos(camera, camera_get_view_x(camera)+xdif,camera_get_view_y(camera));
	//camera_apply(camera);
}
	
//exists on the pixel boundaries
/*if(velocity>0){
	offset+=frac(global.state.x);
	global.state.x=floor(global.state.x);
}
else{
	offset+=frac(global.state.x)-1;
	global.state.x=floor(global.state.x)-1;
}
if(offset>1){
	offset-=1;
	global.state.x+=1;
}
else if(offset<1){
	offset+=1
	global.state.x-=1;
}*/
//animation
#region animation
///*
if(global.state.can_jump){
	if(global.state.vx==0){
		if(keyboard_check(KEY_LEFT) or keyboard_check(KEY_RIGHT)){
			animator.play(walk);
		}
		else{
			animator.play(idle);
		}
	}
	else if(global.state.ax!=0 and sign(global.state.ax)!=sign(global.state.vx)){
		animator.play(skid);
	}
	else
		animator.play(walk);
}//*/
#endregion
#region update state
global.state.spr_index=sprite_index;
global.state.img_index=image_index;
ring_push(ring_buffer, variable_clone(global.state, 1));
} //above this are affected by global._pause
sprite_index=global.state.spr_index;
image_index=global.state.img_index
x=global.state.x;
y=global.state.y;
image_xscale=global.state.xscale;
#endregion
}
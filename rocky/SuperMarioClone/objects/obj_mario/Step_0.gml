#macro ACCELERATION 125
#macro ACCELERATION_RUN 180
#macro DECCELERATION 220
#macro KEY_LEFT ord("A")
#macro KEY_RIGHT ord("D")
#macro SPRITE_LEN 16
#macro SPRITE_LEN_HALF 8
#macro COLLISION_OFFSET 7

//show_debug_message(string(x)+","+string(y));

dt=delta_time/1000000;
if(dt<0.05){
//----------------
//----movement----
//----------------
accelerationx=0;
accelerationy=0;
//	horizontal
if(keyboard_check(KEY_LEFT) and velocityx>-maxSpeed){
	accelerationx-=(keyboard_check(vk_shift)?ACCELERATION_RUN:ACCELERATION);
	//velocityx-=(keyboard_check(vk_shift)?ACCELERATION_RUN:ACCELERATION)*dt;
}
else if(keyboard_check(KEY_RIGHT) and velocityx<maxSpeed){
	accelerationx+=(keyboard_check(vk_shift)?ACCELERATION_RUN:ACCELERATION);
	//velocityx+=(keyboard_check(vk_shift)?ACCELERATION_RUN:ACCELERATION)*dt;
}
else{
	acc=sign(velocityx)*DECCELERATION*dt;
	if(abs(acc)>abs(velocityx))
		velocityx=0;
	//if(abs(velocityx)<1)
		//velocityx=0;
	else{
		//accelerationx-=sign(velocityx)*DECCELERATION;
		velocityx-=acc;
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
if(can_jump and keyboard_check_pressed(ord("W")) and velocityy<40){
	velocityy=-jump_acceleration;
	animator.play(jump);
	can_jump=false;
	jump_press_time=0;
}
if(jump_press_time<max_jump_press_time&&!isFalling&&keyboard_check(ord("W"))){
	jump_press_time+=dt;
	velocityy=-jump_acceleration;
}
if(keyboard_check_released(ord("W")))
	jump_press_time=1000000;
	
//----gravity----
accelerationy+=g;

//-----------------
//-velocity update-
//-----------------
//----collision----
//-----------------
velocityx+=accelerationx*dt;
velocityy+=accelerationy*dt;
x+=velocityx*dt;
if(place_meeting(x,y,tilemap)){
	if(clipping!=0){
		//show_debug_message("1");
		x-=velocityx*dt;
		x+=clipping*((x&15)-8)*(dt*7);
		
		velocityx=0;
		accelerationx=0;
	}
	else{
		x&=~15;
		x+=SPRITE_LEN_HALF;
		velocityx=0;
		accelerationx=0;
	}
}
y+=velocityy*dt;
if(place_meeting(x,y,tilemap)){
	if(velocityy>0){ /////////-------------on landing (from jump)---------------
		can_jump=true;
		isFalling=false;
		y&=~15;
		y+=SPRITE_LEN_HALF;
		velocityy=0;
		clipping=0;
	}
	else if(velocityy<0){
		if(levelCollision(x,y-16,tilemap)==0){//--------------clips through the edge----------
			if((x&15)<SPRITE_LEN_HALF and (x&15)>(SPRITE_LEN_HALF-COLLISION_OFFSET) and velocityx<=0){//on the right
				clipping=1;
			}
			else if((x&15)>SPRITE_LEN_HALF and (x&15)<SPRITE_LEN_HALF+COLLISION_OFFSET and velocityx>=0){//on the left
				clipping=-1;
			}//-------------------------------------------------------------------------------
			else{
				isFalling=true;
				jump_press_time=1000000;
				clipping=0;
				y&=~15;
				y+=SPRITE_LEN_HALF;
				velocityy=0;
			}
		}
		else{
			isFalling=true;
			jump_press_time=1000000;
			clipping=0;
			y&=~15;
			y+=SPRITE_LEN_HALF;
			velocityy=0;
		}
	}
	else{
		isFalling=true;
		jump_press_time=1000000;
		y&=~15;
		y+=SPRITE_LEN_HALF;
		velocityy=0;
		clipping=0;
	}
}


//-----------------
//-----scaling-----
//-----------------
if(velocityx==0){
	image_xscale=accelerationx>=0?1:-1;
}
else
	image_xscale=velocityx>=0?1:-1;

//------------------------------
//-cannot move outside the room-
//------------------------------

left=camera_get_view_x(camera)+SPRITE_LEN_HALF;
right=left+view_width-abs(sprite_width);
up=camera_get_view_y(camera)+SPRITE_LEN_HALF;
down=up+view_height-abs(sprite_height);
if(left>x){
	x=left;
	velocityx=0;
}
else if(right<x){
	x=right;
	velocityx=0;
}
if(down<y){
	y=down;
	velocityy=0;
}
else if(up>y){
	y=up;
	velocityy=0;
}
//----------------------
//-----set viewport-----
//----------------------
xdif=x-left-(view_width>>1);
if(xdif>0){
	//camera_get_view_x(camera)+xdif
	camera_set_view_pos(camera, camera_get_view_x(camera)+xdif,camera_get_view_y(camera));
	//camera_apply(camera);
}
	
//exists on the pixel boundaries
/*if(velocity>0){
	offset+=frac(x);
	x=floor(x);
}
else{
	offset+=frac(x)-1;
	x=floor(x)-1;
}
if(offset>1){
	offset-=1;
	x+=1;
}
else if(offset<1){
	offset+=1
	x-=1;
}*/
//animation
#region animation
///*
if(can_jump){
	if(velocityx==0){
		if(keyboard_check(KEY_LEFT) or keyboard_check(KEY_RIGHT)){
			animator.play(walk);
		}
		else{
			animator.play(idle);
		}
	}
	else if(accelerationx!=0 and sign(accelerationx)!=sign(velocityx)){
		animator.play(skid);
	}
	animator.play(walk);
}//*/
#endregion
}
#macro ACCELERATION 125
#macro ACCELERATION_RUN 180
#macro DECCELERATION 220

//show_debug_message(string(x)+","+string(y));

dt=delta_time/1000000;
if(dt<0.05){
//----------------
//----movement----
//----------------

//	horizontal
if(keyboard_check(ord("A")) and velocityx>-maxSpeed){
	velocityx-=(keyboard_check(vk_shift)?ACCELERATION_RUN:ACCELERATION)*dt;
}
else if(keyboard_check(ord("D")) and velocityx<maxSpeed){
	velocityx+=(keyboard_check(vk_shift)?ACCELERATION_RUN:ACCELERATION)*dt;
}
else{
	if(abs(velocityx)<1)
		velocityx=0;
	else{
	velocityx-=sign(velocityx)*DECCELERATION*dt;
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
if(can_jump and keyboard_check_pressed(ord("W"))){
	velocityy=-jump_acceleration;
	sprite_index=spr_mario_jump;
	can_jump=false;
	jump_press_time=0;
}
if(jump_press_time<max_jump_press_time&&keyboard_check(ord("W"))){
	jump_press_time+=dt;
	velocityy=-jump_acceleration;
}
if(keyboard_check_released(ord("W")))
	jump_press_time=1000000;
velocityy+=g*dt;

//-----------------
//-velocity update-
//-----------------
//----collision----
//-----------------

x+=velocityx*dt;
if(CheckTileCollisionX()){
	x&=~15;
	x+=(abs(sprite_width)>>1);
	velocityx=0;
}
y+=velocityy*dt;
if(CheckTileCollisionY()){
y&=~15;
y+=(abs(sprite_height)>>1);
if(velocityy>0){ /////////-------------on landing (from jump)---------------
	can_jump=true;
	sprite_index=velocityx==0?spr_mario_idle:spr_mario_walk;
}
velocityy=0;
}


//-----------------
//-----scaling-----
//-----------------
image_xscale=velocityx>0?1:-1;

//------------------------------
//-cannot move outside the room-
//------------------------------

left=camera_get_view_x(camera)+(abs(sprite_width)>>1);
right=left+view_width-abs(sprite_width);
up=camera_get_view_y(camera)+(abs(sprite_height)>>1);
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
if(can_jump){
if(velocityx==0)
	sprite_index=spr_mario_idle;
else{
	sprite_index=spr_mario_walk;
}
}
}
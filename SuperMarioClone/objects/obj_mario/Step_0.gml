#macro ACCELERATION 125
#macro ACCELERATION_RUN 180
#macro DECCELERATION 220

dt=delta_time/1000000;

//movement
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
//	vertical
if(keyboard_check(vk_space)){
	velocityy=-180;
}
velocityy+=g*dt;

//velocity update
x+=velocityx*dt;
y+=velocityy*dt;

//scale
image_xscale=velocityx>0?1:-1;

//check collision
left=viewport[1]+abs(sprite_width)>>1;
//left=viewport[1];
right=left+room_width-abs(sprite_width);
up=viewport[2]+abs(sprite_height)>>1;
down=up+room_height-abs(sprite_height);
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
if(velocityx==0)
	sprite_index=spr_mario_idle;
else{
	sprite_index=spr_mario_walk;
}

//x=floor(x);
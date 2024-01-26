#macro ACCELERATION 120

dt=delta_time/1000000;

//movement
if(keyboard_check(ord("A")) and velocity>-maxSpeed){
	velocity-=ACCELERATION*dt;
}
else if(keyboard_check(ord("D")) and velocity<maxSpeed){
	velocity+=ACCELERATION*dt;
}
else{
	if(abs(velocity)<1)
		velocity=0;
	else{
	velocity-=sign(velocity)*ACCELERATION*dt;
	}
}

if(keyboard_check_pressed(vk_shift)){
	maxSpeed=sprintSpeed;
}
else if(keyboard_check_released(vk_shift)){
	maxSpeed=normSpeed;
}
x+=velocity*dt;
//scale
image_xscale=velocity>0?1:-1;

//check collision
left=viewport[1];
right=left+room_width;
if(left>x){
	x=left;
}
if(right<x)
	x=right;
	
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
if(velocity==0)
	sprite_index=spr_mario_idle;
else{
	sprite_index=spr_mario_walk;
}

//x=floor(x);
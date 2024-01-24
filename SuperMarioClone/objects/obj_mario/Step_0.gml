#macro SPEED 60
#macro ACCELERATION 90

dt=delta_time/1000000;

if(keyboard_check(ord("A")) and velocity>-SPEED){
	velocity-=ACCELERATION*dt;
}
else if(keyboard_check(ord("D")) and velocity<SPEED){
	velocity+=ACCELERATION*dt;
}
else if(velocity!=0){
	velocity-=sign(velocity)*ACCELERATION*dt;
}
x+=velocity*dt;
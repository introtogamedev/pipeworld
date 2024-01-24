#macro SPEED 4


if(keyboard_check(ord("A"))){
	x-=SPEED;
}
if(keyboard_check(ord("D"))){
	x+=SPEED;
}
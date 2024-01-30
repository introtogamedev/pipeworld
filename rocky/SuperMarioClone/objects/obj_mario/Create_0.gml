/// @description Insert description here
// You can write your code in this editor

//movement
normSpeed=80;
sprintSpeed=160;
maxSpeed=normSpeed;

g=800;

//jump
jump_height=2.5*16
jump_acceleration=sqrt((g*jump_height)<<1);
can_jump=true;


velocityx=0
velocityy=0;
viewport=room_get_viewport(Room1,0);

offset=0;

function CheckTileCollisionY(){
	tile=levelCollision(x,y+(sign(velocityy)<<4));
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
	tile=levelCollision(x+(sign(velocityx)<<4),y);
	if(tile<=0)
		return false;
	left=x-(abs(sprite_width)>>1);
	right=left+abs(sprite_width);
	l=(((x+(sign(velocityx)<<4))>>4)<<4);
	r=l+16;
	//show_debug_message("tile="+string(tile)+", "+string(left)+","+string(right)+"|"+string(l)+","+string(r));
	return ((l>=left and l<=right) or (r>=left and r<=right));
}
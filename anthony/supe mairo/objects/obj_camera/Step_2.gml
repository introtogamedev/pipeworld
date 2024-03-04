//camera when reach edge
if (x < 0) x = 0;
if (x + view_width) > room_width
{
	x = room_width - view_width;	
}

camera_set_view_pos(view_camera[0],x,y);






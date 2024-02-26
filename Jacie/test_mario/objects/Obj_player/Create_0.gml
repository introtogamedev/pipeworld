//movement
hsp = 0;
vsp = 0;
max_spd = 2;
ac = 0.05;

//jumping
grav = 0.3;
jump_spd = 6.5;



//animation
state = "IDLE";
animation_spd = 0.2;
last_state = "IDLE";



//create snapper follower
instance_create_layer(x,y,"Instances",Obj_follower);
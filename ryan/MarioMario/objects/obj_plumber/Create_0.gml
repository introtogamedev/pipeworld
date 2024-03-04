#region utility variables
	#macro MS 100000
	#macro TILE_SIZE 16
	
	deltaTime = 0; //initialize to 0;
	
	#macro DEBUG_MODE true
	
	#macro INPUT_PAUSE (ord("N"))
	#macro INPUT_DEBUG_NEXTFRAME ord("K")
	pause = false
	tempframe = false //allows for running of one frame only

	//#macro CAMERA_INDEX 0
#endregion

#region Tilemap/sprite Indexes
	//utility
	#macro tilemapLayer  layer_get_id(TILESET_COLLIDABLE)
	#macro tilemapID  layer_tilemap_get_id(tilemapLayer)
	//layers
	#macro TILESET_COLLIDABLE "Tilemap_collidable"
	//tiles
	#macro TILE_FLOOR 1

	
	#macro SPRITE_X_OFFSET abs(sprite_width/2)
	#macro  SPRITE_FOOT_OFFSET abs(sprite_width/4)
#endregion

#region INPUT
	#macro INPUT_LEFT ord("A")
	#macro INPUT_RIGHT ord("D")
	#macro INPUT_RUN vk_shift
	#macro INPUT_JUMP vk_space
#endregion

#region Movement Tuning
	#region horizontal movement
		#macro RELEASE_DEACCEL 0.05078125 * fps //000D0 in HEX
		
		#macro SKIDDING_DEACCEL 0.1015625 * fps //001A0 in HEX
		
		#macro SKID_TURNAROUND 0.5625 //00900 in HEX
		
		#macro MIN_WALK_SPD  0.07421875 * fps //00130 in HEX
		
		#macro WALK_ACCEL 0.037109375 * fps //00098 in HEX
		#macro WALK_SPEED_MAX 1.5625 * 10//01900 in HEX
		
		#macro RUN_ACCEL 0.0556640625 * fps //000E4 in HEX
		#macro RUN_SPEED_MAX 2.5625 * 10 //02900 in HEX
		
		#macro MAX_SPEED_GRAD
		
	#endregion

	#region vertical movement
		#macro JUMP_VEL_TRIG_SLOW 1//TRIGGER: 01000 in HEX
		#macro JUMP_VEL_TRIG_FAST 2.3125 //TRIGGER: 02500 in HEX
		
		#macro JUMP_VEL_SLOW 4 * 6.5  //04000 in HEX : initial x speed < 01000 in HEX
		#macro JUMP_VEL_MED 4  * 6.5//04000 in HEX: initial x speed < 02500 in HEX
		#macro JUMP_VEL_FAST 5 * 6.5//05000 in HEX: initial x speed >= 02500 in HEX
		
		#macro JUMP_HOLD_GRAV_SLOW 0.125 * fps //00200 in HEX
		#macro JUMP_HOLD_GRAV_MED 0.1171875 * fps //001E0 in HEX
		#macro JUMP_HOLD_GRAV_FAST 0.15625 * fps //00280 in HEX
		
		#macro FALL_GRAV_SLOW 0.4375 * fps // 00700 in HEX
		#macro FALL_GRAV_MED 0.375 * fps //00600 in HEX
		#macro Fall_GRAV_FAST 0.5625 * fps //00900 in HEX
		
		#macro AIR_TRIG 1.562//01900 in HEX
		#macro AIR_TRIG_JUMP 1.8125// 01D00 in HEX
		
		#macro AIR_FOR_SLOW 0.037109375 * fps //00098 in HEX: current x speed < 01900 in HEX
		#macro AIR_FOR_FAST 0.0556640625 * fps //000E4 in HEX: current x speed >= 01900 in HEX
		
		#macro AIR_BACK_FAST  0.0556640625 * fps //000E4 in HEX: current x speed >= 01900 in HEX
		#macro AIR_BACK_SLOW_JUMP_FAST 0.05078125 * fps // 000D0 in HEX: Current x speed < 01900, started jump at >= 01D00 in HEX
		#macro AIR_BACK_SLOW_JUMP_SLOW 0.037109375* fps // 000D0 in HEX: Current x speed < 01900, started jump at < 01D00 in HEX
	
	#endregion
#endregion

#region saved variables
	xvelocity = 0;//initialize to 0;
	yvelocity = 0;//initialize to 0;

	runActivate = false;//initialize to false;
	skidding = false;//initialize to false;
	
	facing_dir = 1;//initialize to 1;
	
	onGround = false;//initialize to false
	
	jumpTriggered = false;//initialize to false;
	
	//Animation variables
	plumberAnimation = {
		running: false,//initialize to false
		jumping: false,//initialize to false
		xmoving: false,//initialize to false
		ymoving: false,//initialize to false *not used yet
		turning: false, //initialize to false
	}
	
	jump_initial_xvelocity = 0;
#endregion

#region functions

function playsoundEff(audio, priority, override){
	if (not audio_is_playing(audio) or override){
		audio_play_sound(audio, priority, false);
	}
}

function saveStateToStruct(){
	var struct = {
		x, 
		y,
		xvelocity,
		yvelocity,
		facing_dir,
		
		jumpTriggered,
		
		plumberAnimation,
	}
	global.saveState = struct;
}

function loadState(){
	var struct  = global.saveState;
	x = struct.x;
	y = struct.y;
	//xvelocity = struct.xvelocity;
	//yvelocity = struct.yvelocity;
	facing_dir = struct.facing_dir;
	
	jumpTriggered = struct.jumpTriggered;
	
	plumberAnimation = struct.plumberAnimation;
}
if (global.saveState != undefined){
	loadState();
}
#endregion

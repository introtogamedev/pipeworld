#region utility variables
	#macro MS 1000000
	#macro TILE_SIZE 16
	
	deltaTime = 0; //initialize to 0;
	
	#macro DEBUG_MODE true
	
	#macro INPUT_PAUSE (ord("N"))
	#macro INPUT_DEBUG_NEXTFRAME vk_right
	pause = false
	tempframe = false //allows for running of one frame only

	//#macro CAMERA_INDEX 0
#endregion

#region Tilemap/sprite Indexes
	//utility
	tilemapLayer = layer_get_id(TILESET_COLLIDABLE);
	tilemapID = layer_tilemap_get_id(tilemapLayer);
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
		#macro MOVE_ACCEL 15 * fps
		#macro MOVE_DEACCEL 7 * fps
		#macro MAX_SPD 2 * fps

		#macro MOVE_SPRINT_ACCEL 30 * fps
		#macro MOVE_SPRINT_DEACCEL 15 * fps
		#macro MAX_SPD_SPRINT 4 *fps
		
	#endregion

	#region vertical movement
		#macro FALL_GRAVITY 17 * fps
		#macro TERMINAL_VELOCITY 30 * fps
		
		#macro JUMP_GRAVITY  5 * fps
		#macro JUMP_VEL 4  * fps 
		#macro JUMP_HEIGHT_MAX  1 * TILE_SIZE
	
	#endregion
#endregion

#region saved variables
	xvelocity = 0;//initialize to 0;
	yvelocity = 0;//initialize to 0;

	runActivate = false;//initialize to false;
	facing_dir = 1;//initialize to 1;
	
	onGround = false;//initialize to false
	
	jumpTriggered = false;//initialize to false;
	jumpAllowed = false;//initialize to false;
	jump_height = 0;//initialize to 0;
	
	//Animation variables
	plumberAnimation = {
	running: false,//initialize to false
	jumping: false,//initialize to false
	xmoving: false,//initialize to false
	ymoving: false,//initialize to false *not used yet
	turning: false, //initialize to false
	}
#endregion

#region functions

function playsoundEff(audio, priority){
	if (not audio_is_playing(audio)){
		audio_play_sound(audio, priority, false)
	}
}
#endregion
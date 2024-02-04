#region utility variables
	#macro MS 1000000
	#macro TILE_SIZE 16

	//#macro CAMERA_INDEX 0
#endregion

#region Tilemap/sprite Indexes
	//layers
	#macro TILESET_COLLIDABLE "Tilemap_collidable"
	//tiles
	#macro TILE_FLOOR_ID 1 
#endregion

#region INPUT
	#macro INPUT_LEFT ord("A")
	#macro INPUT_RIGHT ord("D")
	#macro INPUT_RUN vk_shift
	#macro INPUT_JUMP vk_space
#endregion

#region Movement Tuning
	#region horizontal movement
		#macro MOVE_ACCEL 5 * fps
		#macro MOVE_DEACCEL 8 * fps
		#macro MAX_SPD 4 * fps

		#macro MOVE_SPRINT_ACCEL 8 * fps
		#macro MOVE_SPRINT_DEACCEL 6 * fps
		#macro MAX_SPD_SPRINT 7 *fps

		#macro SPR_SPEEDRUN_TRIGGER 3 //used for animations
		#macro SPR_RUN_TRIGGER 3 //used for animations

	#endregion

	#region vertical movement
		#macro GRAVITY 12 * fps
		#macro TERMINAL_VELOCITY 16 * fps
		#macro JUMP_VEL 3  * fps
		#macro JUMP_HEIGHT_MAX  3.5 * TILE_SIZE
	#endregion
#endregion

#region saved variables
	xvelocity = 0;//initialize to 0;
	yvelocity = 0;//initialize to 0;

	runActivate = false;//initialize to false;
	facing_dir = 1;//initialize to 1;

	onGround = false;//initialize to false
	
	jumpAllowed = false;//initialize to false;
	jump_height = 0;//initialize to 0;
#endregion





// -- constants --
#macro MOVE_SPEED  5
#macro INPUT_LEFT  ord("A")
#macro INPUT_RIGHT ord("D")

// -- step --
function step() {
	if (keyboard_check(INPUT_LEFT)) {
		x -= MOVE_SPEED;	
	}

	if (keyboard_check(INPUT_RIGHT)) {
		x += MOVE_SPEED;	
	}
}

// -- run --
step();
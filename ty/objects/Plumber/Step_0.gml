// ---------------
// -- constants --
// ---------------

// the number of frames per second
#macro FPS 60

// the number of microseconds in a second
#macro MS 1000000

// -- move tuning --
#macro MOVE_WALK_ACCELERATION 1.2 * FPS

// -- input --
#macro INPUT_LEFT  ord("A")
#macro INPUT_RIGHT ord("D")

// ---------------
// -- get input --
// ---------------

// in this section, we'll read player input to use later when
// we update the character

// add input direction; add left input and right input so that 
// if both buttons are pressed, the input direction is 0
var _input_move = 0;
if (keyboard_check(INPUT_LEFT)) {
	_input_move -= 1;	
}

if (keyboard_check(INPUT_RIGHT)) {
	_input_move += 1;
}

// ------------------
// -- add "forces" --
// ------------------

// in this section, we'll run most of our "game logic". what forces
// and other physical changes we make in response to player input.

// start with 0 forces every frame!
var _ax = 0;

// add move acceleration
_ax += MOVE_WALK_ACCELERATION * _input_move;

// ---------------
// -- integrate --
// ---------------

// here's where we "do physics"! given the forces and changes we
// calculated in the previous step, update the character's velocity
// and position to their new state.

// get fractional delta time
var _dt = delta_time / MS;

// integrate acceleration into velocity
// v1 = v0 + a * t
vx += _ax * _dt;

// integrate velocity into position
// p1 = p0 + v * t
px += vx * _dt;

// --------------------
// -- update outputs --
// --------------------

// set any outputs we need in subsequent steps, such as for drawing
// the character. eventually, we should have nothing here!

// update the built-in position
x = px;
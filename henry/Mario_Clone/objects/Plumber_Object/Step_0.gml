// constants//macro 
#macro DT 0.016667
// the number of accroseconds in a second?????
#macro MS 100000

//move constants

#macro MOVE_ACCEL .1 / DT

//input constants
#macro INPUT_LEFT ord("A")
#macro INPUT_RIGHT ord("D")

// -- step --
// find the input direction
var _input_dir = 0;
if keyboard_check(ord("A")) {_input_dir -=1}

if keyboard_check(ord("D")) {_input_dir +=1}

// get the move accepperation
var _ax = MOVE_ACCEL * _input_dir


// get fractional delta time
var _dt = delta_time / MS;


// accepperation -->into velicit
vx += _ax;

//velocity --> position

x += _ax * _dt;

if keyboard_check_pressed(vk_escape) {game_end()}

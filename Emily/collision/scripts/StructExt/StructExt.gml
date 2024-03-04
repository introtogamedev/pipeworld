/// creates a copy of the struct. for example, given the following
/// struct:
///
///   var _a = {
///     x: 6,
///     y: 8
///   }
///
/// making and changing a copy will work only affect the copy, but
/// not the original:
///
///   var _b = struct_copy(_a);
///   _b.x = 3;
///
///   show_debug_message("{0},{1}", _b.x, _b.y) // 3,8
///   show_debug_message("{0},{1}", _a.x, _a.y) // 6,8
///
/// - arguments:
///   * src:   the struct to make a copy of
///   * depth: how many levels deep to copy (defualts to 1)
/// - returns: a copy of the struct
function struct_copy(_src, _depth = 1) {
	return variable_clone(_src, _depth);
}

/// update the struct `dst` with values from another struct `src`.
/// for example, given the following structs:
///
///   var _a = {
///     x: 6,
///     y: 8
///   }
///
///   var _b = {
///     x: 9,
///     z: 0
///   }
///
/// updating "a" will only set the values from "b" that "a" also has:
///
///   struct_update(_a, _b);
///   show_debug_message("{0},{1}", _a.x, _a.y) // 9,8
///   show_debug_message("{0},{1}", _b.x, _b.z) // 9,0 (note _b.z here)
///
/// - arguments:
///   * dst: the struct to update
///   * src: the struct to get new values from
function struct_update(_dst, _src) {
	var _names = variable_struct_get_names(_dst);

	// for every prop in the destination struct
	for (var _i = 0; _i < array_length(_names); _i++) {
		var _name = _names[_i];

		// set it to the value from the source struct, if it exists
		if (struct_exists(_src, _name)) {
			struct_set(_dst, _name, struct_get(_src, _name));
		}
	}
}
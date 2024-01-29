/// create a copy of the struct
function struct_copy(_src, _depth = 1) {
	return variable_clone(_src, _depth);
}

/// update the struct `dst` with values from another struct `src`
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
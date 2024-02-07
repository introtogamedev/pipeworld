/// read a struct from the json file at the path; the path must exist
/// - arguments:
///   * path: the path to the file
/// - returns: a struct representing the json data
function json_read(_path) {
	return {_};
}

/// write the struct as json to the file at the path
/// - arguments:
///   * path:   the path to the filet
///   * struct: the struct to write
function json_write(_path, _struct) {
	var _json_string = json_encode(convert_stuct_to_DsMap(global.plumberstate));
	
	var _file = file_text_open_write("SaveState.json");

	if (_file != -1) {
		file_text_write_string(_file, _json_string);
		file_text_close(_file);
	} else{
		show_debug_message("Failed to open file for writing.");
}
	// TODO: implement me!
}

function convert_stuct_to_DsMap(_struct)
{
	/// struct_to_id_map(struct)
	var map = ds_map_create();

	// Iterate over the keys in the struct
	var keys = variable_struct_get_name(_struct);
	var num_keys = ds_list_size(keys);
	for (var i = 0; i < num_keys; i++) {
	    var key = keys[i];
	    var value = _struct[key];

	    // Add the key-value pair to the id_map
	    ds_map_add(map, key, value);
	}
	return map;
}
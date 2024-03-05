/// read a struct from the json file at the path; the path must exist
/// - arguments:
///   * path: the path to the file
/// - returns: a struct representing the json data
function json_read(_path) {
	var _file = file_text_open_read(_path);
	if (_file != -1) // Check if the file was opened successfully
	{
    /// Read the contents of the file as a string
    var _json_string = file_text_read_string(_file);
	
	while (!file_text_eof(_file)) {
		_json_string += file_text_read_string(_file);
		 file_text_readln(_file);
	}
    /// Close the file
    file_text_close(_file);

    /// Parse the JSON string into a data structure
    var _data_struct = json_parse(_json_string);
	return _data_struct;
	}
	show_debug_message("file not opened sucessfully")
	return;
}

/// write the struct as json to the file at the path
/// - arguments:
///   * path:   the path to the filet
///   * struct: the struct to write
function json_write(_path, _struct) {
	var _json_string = json_stringify(_struct);
	show_debug_message(_json_string);
	var _file = file_text_open_write(_path);

	if (_file != -1) {
		file_text_write_string(_file, _json_string);
		file_text_close(_file);
		show_debug_message("File Write Sucess");
	} else{
		show_debug_message("Failed to open file for writing.");
	}

}


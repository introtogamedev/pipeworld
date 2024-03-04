/// read a json file at the path; the path must exist
/// - arguments:
///   * path: the path to the file
/// - returns: a struct representing the json data
function json_read(_path) {
	var _file = file_text_open_read(_path);
	var _json = file_text_read_string(_file);
	file_text_close(_file);
	return json_parse(_json);
}

/// write a struct as json to the file at the path
/// - arguments:
///   * path:   the path to the file
///   * struct: the struct to write
function json_write(_path, _struct) {
	var _json = json_stringify(_struct);
	var _file = file_text_open_write(_path);
	file_text_write_string(_file, _json);
	file_text_close(_file);
}
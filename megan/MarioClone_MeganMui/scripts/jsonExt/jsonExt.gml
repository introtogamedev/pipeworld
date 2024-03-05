// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function json_read(_path)
{
	var _file = file_text_open_read(_path);
	var _json = file_text_read_string(_file);
	file_text_close(_file);
	return json_parse(_json);
}

function json_write(_path, _struct) {
	var _json = json_stringify(_struct);
	var _file = file_text_open_write(_path);
	file_text_write_string(_file, _json);
	file_text_close(_file);
}
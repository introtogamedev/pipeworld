global.currentState = {};
function saveToJSON(_file_name = "save.json"){
	var json_str = json_stringify(global.currentState, true);
	var file = file_text_open_write(_file_name);
	
	file_text_write_string(file, json_str);
	
	
	file_text_close(file);
}

function loadJSON(_file_name = "save.json"){
	if(file_exists(_file_name)){
		var file = file_text_open_read(_file_name);
		var json_str = "";
		while(not file_text_eof(file)){
			json_str += file_text_read_string(file);
			file_text_readln(file);
		}
		file_text_close(file);
		return json_parse(json_str);
	}
	return undefined;
}


show_debug_message("Loading game files....")

//loading in JSON files
global.currentState = loadJSON();

show_debug_message("JSON FILES SUCESSFULLY LOADED");



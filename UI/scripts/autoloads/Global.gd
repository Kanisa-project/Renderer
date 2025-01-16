extends Node

var loaded_masterpiece = {}

var primary_color := Color(0, 0, 0)
var secondary_color := Color(0.5, 0.5, 0.5)
var thirdary_color := Color(1, 1, 1)

var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	rng.randomize()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func round_to_dec(num, digit) -> float:
	return round(num * pow(10.0, digit)) / pow(10.0, digit)


func load_random_json_file(directory_path: String) -> Dictionary:
	if directory_path == "":
		directory_path = "res://MASTERPIECEs"
	var random_file = get_random_file(directory_path)
	if random_file != "":
		var json_data = load_json_file(directory_path + "/" + random_file)
		if json_data:
			print("JSON results: ", json_data)
			return json_data
		return {}
	return {}

func get_random_file(directory_path) -> String:
	var dir = DirAccess.open(directory_path)
	var files = []
	dir.list_dir_begin()
	var file_name = dir.get_next()
	while file_name != "":
		if not dir.current_is_dir() and file_name.ends_with(".json"):
			files.append(file_name)
		file_name = dir.get_next()
	dir.list_dir_end()
	if files.size() == 0:
		print("No files found in the directory: ", directory_path)
		return ""
		
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var random_index = rng.randi_range(0, files.size() - 1)
	return files[random_index]

func load_json_file(file_path: String):
	if FileAccess.file_exists(file_path):
		var file = FileAccess.open(file_path, FileAccess.READ)
		var parsed_result = JSON.parse_string(file.get_as_text())
		if parsed_result is Dictionary:
			return parsed_result
		else:
			print("Are you sure this is a dict/JSON?")
	else:
		print("No file with this path: " + file_path)
		
func fetch_masterpieces() -> Array:
	var found_masterpieces = []
	var dir = DirAccess.open("res://MASTERPIECEs")
	dir.list_dir_begin()
	var file_name = dir.get_next()
	while file_name != "":
		if not dir.current_is_dir() and file_name.ends_with(".json"):
			found_masterpieces.append(file_name)
		file_name = dir.get_next()
	dir.list_dir_end()
	if found_masterpieces.size() == 0:
		print("No Masterpieces found.")
	return found_masterpieces

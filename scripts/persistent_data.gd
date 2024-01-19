extends Node

# The persistent data to preserve between runs
# Keep in mind that this won't automatically load/save. The corresponding functions must be called.
var persistent_data = {}

# This function loads the persistent data from the user's save file and stores it in persistent_data
func load_data():
	print("Loading Save Data...")
	
	var file = FileAccess.open("user://save_game.dat", FileAccess.READ)
	
	if file == null:
		print("No save data found or there was an error in opening the file. Writing new save data.")
		save_data()
		return
	
	
	var json = JSON.new()
	var error = json.parse(file.get_as_text())
	
	if error == OK:
		if typeof(json.data) == TYPE_DICTIONARY:
			persistent_data = json.data
			print("Successfully Loaded Save Data")
			return
	
	# if we reach here, there was an issue
	print("Corrupted Data. No data loaded!")  # todo backup this data?

# This function takes the current persistent data and saves it to the user's save file
func save_data():
	print("Saving Data...")
	var file = FileAccess.open("user://save_game.dat", FileAccess.WRITE)
	file.store_string(JSON.stringify(persistent_data))


# relevant docs
# https://docs.godotengine.org/en/stable/classes/class_json.html
# https://docs.godotengine.org/en/stable/classes/class_fileaccess.html
# https://docs.godotengine.org/en/stable/tutorials/io/data_paths.html
# https://docs.godotengine.org/en/stable/tutorials/scripting/singletons_autoload.html

extends Control

# Reference: https://www.youtube.com/watch?v=Mx3iyz8AUAE

# the click sound is a singleton so its sound isn't bound to one particular scene
# https://docs.godotengine.org/en/stable/tutorials/scripting/singletons_autoload.html

func _ready():
	$VBoxContainer/Start.grab_focus()
	get_node("/root/PersistentData").load_data()
	
func _on_start_pressed():
	get_node("/root/ClickSound").play()
	get_tree().change_scene_to_file("res://scenes/level.tscn")

func _on_options_pressed():
	get_node("/root/ClickSound").play()
	pass # Replace with function body.


func _on_exit_pressed():
	get_node("/root/ClickSound").play()
	get_tree().quit()

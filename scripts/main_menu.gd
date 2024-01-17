extends Control

# Reference: https://www.youtube.com/watch?v=Mx3iyz8AUAE

func _ready():
	$VBoxContainer/Start.grab_focus()
	
func _on_start_pressed():
	get_tree().change_scene_to_file("res://level.tscn")


func _on_options_pressed():
	pass # Replace with function body.


func _on_exit_pressed():
	get_tree().quit()
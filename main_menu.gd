extends Control

func _on_start_pressed():
	get_tree().change_scene_to_file("res://level.tscn")


func _on_options_pressed():
	pass # Replace with function body.


func _on_exit_pressed():
	get_tree().quit()

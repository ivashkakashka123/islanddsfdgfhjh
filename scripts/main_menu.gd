extends Control


func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/world.tscn")

func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_creators_pressed() -> void:
	OS.shell_open('https://t.me/podruzhechkiis')

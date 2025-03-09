extends Control

@onready var glob = get_node("/root/globals")

func _on_new_game_pressed():
	glob.was_loaded_from_save = false
	get_tree().change_scene_to_file("res://Scenes/intro.tscn")


func _on_config_game_pressed():
	$Config.visible = true


func _on_load_game_pressed() -> void:
	$LoadPage.visible = true

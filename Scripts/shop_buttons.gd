extends Control

func _on_all_pressed() -> void:
	$HBoxContainer/Items.button_pressed = false
	$HBoxContainer/Food.button_pressed = false
	$HBoxContainer/Clothes.button_pressed = false
	$HBoxContainer/MadeInChina.button_pressed = false

func _on_items_pressed() -> void:
	$HBoxContainer/All.button_pressed = false
	$HBoxContainer/Food.button_pressed = false
	$HBoxContainer/Clothes.button_pressed = false
	$HBoxContainer/MadeInChina.button_pressed = false

func _on_food_pressed() -> void:
	$HBoxContainer/All.button_pressed = false
	$HBoxContainer/Items.button_pressed = false
	$HBoxContainer/Clothes.button_pressed = false
	$HBoxContainer/MadeInChina.button_pressed = false

func _on_clothes_pressed() -> void:
	$HBoxContainer/All.button_pressed = false
	$HBoxContainer/Food.button_pressed = false
	$HBoxContainer/Items.button_pressed = false
	$HBoxContainer/MadeInChina.button_pressed = false

func _on_made_in_china_pressed() -> void:
	$HBoxContainer/Food.button_pressed = false
	$HBoxContainer/Clothes.button_pressed = false
	$HBoxContainer/Items.button_pressed = false

extends Node2D

signal resume_game
signal save_game
signal load_game
signal config_page
signal go_to_title
signal exit_game

@onready var glob = get_node("/root/globals")

# Called when the node enters the scene tree for the first time.
func _ready():
	self.z_index = 100
	$Button1.text = "ゲームに戻る"
	$Button2.text = "セーブ"
	$Button3.text = "ロード"
	$Button4.text = "コンフィグ"
	$Button5.text = "タイトルに戻る"
	$Button6.text = "ゲームを閉じる"
	var y = 250
	$Button1.position = Vector2(960 - round($Button1.size.x), y)
	y = y + $Button1.size.y
	$Button2.position = Vector2(960 - round($Button2.size.x), y)
	y = y + $Button1.size.y
	$Button3.position = Vector2(960 - round($Button3.size.x), y)
	y = y + $Button1.size.y
	$Button4.position = Vector2(960 - round($Button4.size.x), y)
	y = y + $Button1.size.y
	$Button5.position = Vector2(960 - round($Button5.size.x), y)
	y = y + $Button1.size.y
	$Button6.position = Vector2(960 - round($Button6.size.x), y)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_1_pressed():
	emit_signal("resume_game")


func _on_button_2_pressed():
	emit_signal("save_game")


func _on_button_3_pressed():
	emit_signal("load_game")


func _on_button_4_pressed():
	emit_signal("config_page")


func _on_button_5_pressed():
	emit_signal("go_to_title")


func _on_button_6_pressed():
	emit_signal("exit_game")

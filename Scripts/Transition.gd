extends Node2D

@onready var glob = get_node("/root/globals")

# Called when the node enters the scene tree for the first time.


func previousFade():
	var previousScreen = glob.holdImage
	if previousScreen != null:
		$Sprite2D.texture = ImageTexture.create_from_image(previousScreen)
		@warning_ignore("confusable_local_declaration")
		var tween = get_tree().create_tween()
		tween.tween_property($Sprite2D, "modulate", Color(0,0,0,1), 0.5)
		await tween.finished
	var tween = get_tree().create_tween()
	tween.tween_property($Sprite2D, "modulate", Color(0,0,0,0), 1)
	await tween.finished
	glob.holdImage = null


func previousFadeWhite():
	var previousScreen = glob.holdImage
	if previousScreen != null:
		$Sprite2D.texture = ImageTexture.create_from_image(previousScreen)
		@warning_ignore("confusable_local_declaration")
		var tween = get_tree().create_tween()
		tween.tween_property($Sprite2D, "modulate", Color(0,0,0,1), 0.5)
		await tween.finished
	var tween = get_tree().create_tween()
	tween.tween_property($Sprite2D, "modulate", Color(0,0,0,0), 1)
	await tween.finished
	glob.holdImage = null

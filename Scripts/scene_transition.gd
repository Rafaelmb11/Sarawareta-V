extends Node2D

@onready var glob = get_node("/root/globals")

# Called when the node enters the scene tree for the first time.
func _ready():
	var previousScreen = glob.holdImage
	if previousScreen != null:
		$Prev.texture = ImageTexture.create_from_image(previousScreen)
		@warning_ignore("confusable_local_declaration")
		var tween = get_tree().create_tween()
		tween.tween_property($Sprite2D, "modulate", Color(0,0,0,1), 0.5)
		await tween.finished
	$Prev.texture = null
	var tween = get_tree().create_tween()
	tween.tween_property($Sprite2D, "modulate", Color(0,0,0,0), 1)
	await tween.finished
	self.queue_free()

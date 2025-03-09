extends Sprite2D

@onready var almostFinished = false

# Called when the node enters the scene tree for the first time.
func _ready():
	var tween = get_tree().create_tween()
	tween.tween_property(self, "modulate", Color("ffffff"), 0.6)
	await tween.finished
	tween = get_tree().create_tween()
	tween.tween_property(self, "modulate", Color("ffffff00"), 0.6)
	await tween.finished
	tween = get_tree().create_tween()
	tween.tween_property(self, "modulate", Color("ffffff"), 0.6)
	await tween.finished
	almostFinished = true
	tween = get_tree().create_tween()
	tween.tween_property(self, "modulate", Color("ffffff00"), 0.6)
	await tween.finished
	
	
func almostdone():
	return almostFinished

extends Node2D

@onready var pos = self.position

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	loop_anim()

func loop_anim():
	var tween
	while true:
		tween = get_tree().create_tween()
		tween.tween_property(self, "position", Vector2(pos.x - ($Sprite2D.texture.get_width()/2)*self.scale.x, pos.y), .8)
		await tween.finished
		tween = get_tree().create_tween()
		tween.tween_property(self, "position", Vector2(pos.x + ($Sprite2D.texture.get_width()/2)*self.scale.x, pos.y), .8)
		await tween.finished
	
	#tween.set_loops()
	

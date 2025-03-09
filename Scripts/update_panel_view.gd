extends Decal

@onready var PANEL_INSTANCE = self.get_parent().get_node("SubViewport")

# Called when the node enters the scene tree for the first time.
func _ready():
	#PANEL_INSTANCE.position = Vector2(1720,880)
	pass
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timer_timeout():
	self.texture_albedo = PANEL_INSTANCE.get_viewport().get_texture()
	

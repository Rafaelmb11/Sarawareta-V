extends Node3D

@onready var target = $"../Room/Cube_011"
@onready var PANEL_INSTANCE = $SubViewport

# Called when the node enters the scene tree for the first time.
func _ready():
	#PANEL_INSTANCE.position = Vector2(1720,880)
	pass
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timer_timeout():
	$Decal.texture_albedo = ImageTexture.create_from_image(PANEL_INSTANCE.get_viewport().get_texture().get_image())
	$Sprite2D.texture = PANEL_INSTANCE.get_viewport().get_texture()
	

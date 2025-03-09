extends StaticBody3D

signal play_animation(anim)
@onready var interaction_level = 0

var is_Tap_Open

# Called when the node enters the scene tree for the first time.
func _ready():
	is_Tap_Open = false
	
func interact():
	if !is_Tap_Open:
		play_animation.emit("Sink_Tap_Open")
		$"../GPUParticles3D".emitting = true
		$"../TapWater".visible = true
		is_Tap_Open = true
	else:
		play_animation.emit("Sink_Tap_Close")
		$"../GPUParticles3D".emitting = false
		$"../TapWater".visible = false
		is_Tap_Open = false
		
func get_interact_text():
	return "Interact [E]"

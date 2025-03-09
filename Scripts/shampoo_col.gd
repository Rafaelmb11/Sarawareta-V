extends StaticBody3D

signal textbox_event(contents)


# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
func interact():
	emit_signal("textbox_event", ["Cheap shampoo..."])
	
func get_interact_text():
		return "Examine [E]"
	

extends StaticBody3D

signal textbox_event(contents)
@onready var interaction_level = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
func interact():
	if interaction_level == 0:
		emit_signal("textbox_event", ["I kinda need to pee... But... They're watching..."])
		interaction_level = interaction_level+1
	else:if interaction_level == 1:
		emit_signal("textbox_event", ["I should be able to hide the important parts, but still...", "Peeing with people watching you is just so humiliating..."])
		interaction_level = interaction_level+1
	else:if interaction_level == 2:
		emit_signal("textbox_event", ["This is an unwinable battle, but still...", "I'll hold it in for as long as possible..."])
	else:if interaction_level == 3:
		pass

func get_interact_text():
	if interaction_level == 0:
		return "Examine [E]"
	if interaction_level >= 1:
		return "Use Toilet [E]"

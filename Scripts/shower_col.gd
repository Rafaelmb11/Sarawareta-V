extends StaticBody3D

signal textbox_event(contents)
@onready var interaction_level = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
func interact():
	if interaction_level == 0:
		emit_signal("textbox_event", ["A shower...", "That surveillance camera is pointing this way...",
	"There's no way to escape their eyes..."])
		interaction_level = interaction_level+1
	else:if interaction_level == 1:
		emit_signal("textbox_event", ["Really need a shower, but I'm not up for giving these degenerates a shower scene..."])
		interaction_level = interaction_level+1
	else:if interaction_level == 2:
		emit_signal("textbox_event", ["I would die from embarrasement! There's no way I'm doing this!"])
	else:if interaction_level == 3:
		pass
	
func get_interact_text():
	if interaction_level == 0:
		return "Examine [E]"
	if interaction_level > 0:
		return "Shower [E]"

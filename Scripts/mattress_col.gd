extends StaticBody3D

signal textbox_event(contents)
@onready var interaction_level = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
func interact():
	if interaction_level == 0:
		emit_signal("textbox_event", ["What a nasty mattress...", 
	"Am I supposed to sleep on this thing? No way..."])
		interaction_level = interaction_level+1
	else:if interaction_level > 0:
		pass
		
func get_interact_text():
	if interaction_level == 0:
		return "Examine [E]"
	if interaction_level > 0:
		return "Rest [E]"

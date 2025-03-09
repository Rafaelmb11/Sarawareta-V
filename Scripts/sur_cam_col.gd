extends StaticBody3D

signal textbox_event(contents)
@onready var interaction_level = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
func interact():
	if interaction_level == 0:
		emit_signal("textbox_event", ["Camera...", 
	"There's no privacy in this room..."])
		interaction_level = interaction_level+1
	else:if interaction_level > 0:
		emit_signal("textbox_event", ["I'm being constantly watched... Even after honey trapping all those morons I still feel somewhat violated..."])
		
func get_interact_text():
	return "Examine [E]"
	

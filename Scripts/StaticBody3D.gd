extends StaticBody3D

signal textbox_event(contents)

@onready var interaction_level = 0
# Called when the node enters the scene tree for the first time.
	
func interact():
	emit_signal("textbox_event", ["This is a very hard brick wall, I will try knocking on it a bit...", 
	"... Could this room be underground?!"])

func get_interact_text():
	return "Examine [E]"

extends StaticBody3D

signal textbox_event(contents)
@onready var interaction_level = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
func interact():
	if interaction_level == 0:
		emit_signal("textbox_event", ["Elevator doors... Looks like one of those food elevators you see in movies...", "There's no way to open it from this room..."])
		interaction_level = interaction_level+1
	else:if interaction_level == 1:
		emit_signal("textbox_event", ["This seems to be the only way in and out of this room..."])
	else:if interaction_level == 2:
		pass

func get_interact_text():
		return "Examine [E]"

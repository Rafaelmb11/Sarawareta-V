extends StaticBody3D

signal textbox_event(contents)
@onready var interaction_level = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
func interact():
	if interaction_level == 0:
		emit_signal("textbox_event", ["An air duct... I don't see any screws, is it just attached?"])
		interaction_level = interaction_level+1
	else:if interaction_level == 1:
		emit_signal("textbox_event", ["I could probably take the lid off if I could reach it..."])
		interaction_level = interaction_level+1
	else:if interaction_level == 2:
		emit_signal("textbox_event", ["Possible escape route? My tits are probably far too big for me to fit inside though...", "Need to get closer and check it out, wonder if I can get some sort of foothold..."])
	else:if interaction_level == 3:
		pass

func get_interact_text():
	if interaction_level == 0:
		return "Examine [E]"
	if interaction_level >= 1:
		return "Examine [E]"

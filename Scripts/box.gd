extends Node3D

@onready var glob = get_node("/root/globals")
signal textbox_event(contents)
signal get_items_from_box
@onready var interaction_level = 0
	
func interact():
	if interaction_level == 0:
		emit_signal("textbox_event", ["A box... The overpriced stuff I bought on that weird panel is probably inside I assume..."])
		interaction_level = interaction_level+1
	else: if interaction_level > 0:
		emit_signal("get_items_from_box")
		
func get_interact_text():
	if interaction_level == 0:
		return "Examine [E]"
	if interaction_level > 0:
		return "Get Items [E]"

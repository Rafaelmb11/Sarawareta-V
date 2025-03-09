extends Node2D

@onready var glob = get_node("/root/globals")


func _on_texture_button_pressed_custom(parent: Node) -> void:
	#Can't use append because it's broken due to this engine being a pile of garbage maintained by a bunch of woke morons
	var item_slots = get_tree().get_nodes_in_group("item_slot")
	var storage_slots = get_tree().get_nodes_in_group("storage_slot")
	
	for i in item_slots:
		if parent != i || parent.isEmpty:
			i.get_node("TextureButton").button_pressed = false
	for i in storage_slots:
		if parent != i || parent.isEmpty:
			i.get_node("TextureButton").button_pressed = false


func _on_move_item_pressed() -> void:
	var item_slots = $Slots.get_children()
	var storage_slots = $Slots2.get_children()
	var all_slots = item_slots
	all_slots.append_array(storage_slots)
	
	for i in all_slots:
		if i.get_node("TextureButton").button_pressed == true:
			var itemName = i.ItemName
			if i.get_groups()[0] == "storage_slot":
				var node_or_false = find_next_empty_or_error(item_slots)
				if node_or_false is Node:
					node_or_false.set_item(itemName)
					i.clear_item()
				else:
					glob.Save["PlayWildDialogue"] = "destination_is_full"
					return
			if i.get_groups()[0] == "item_slot":
				
				var clo = glob.Save["Clothes"]
				for j in clo:
					if clo[j] == itemName:
						#glob.Save["PlayWildDialogue"] = "tried_storing_equipped_item"
						$"../Scenarios".wild_dialogue("tried_storing_equipped_item")
						return
				
				var node_or_false = find_next_empty_or_error(storage_slots)
				if node_or_false is Node:
					node_or_false.set_item(itemName)
					i.clear_item()
				else:
					glob.Save["PlayWildDialogue"] = "destination_is_full"
					return
				
			
	var item_slots_ = get_tree().get_nodes_in_group("item_slot")
	var storage_slots_ = get_tree().get_nodes_in_group("storage_slot")
	
	for i in item_slots_:
			i.get_node("TextureButton").button_pressed = false
	for i in storage_slots_:
			i.get_node("TextureButton").button_pressed = false
	#print(str(all_slots))
	
func find_next_empty_or_error(arr : Array):
	for i in arr:
		if i.isEmpty:
			return i
	return false

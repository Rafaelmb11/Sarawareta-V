extends Node2D

@onready var glob = get_node("/root/globals")

func _ready():
	$CharSprite.changeExpression("neutral")

func _process(delta):
	glob.update_expression($CharSprite)

func _on_texture_button_pressed_custom(parent: Node) -> void:
	var parentName = parent.name
	var all_slots = get_tree().get_nodes_in_group("item_slot")
	for i in all_slots:
		if $Slots.get_node(NodePath(parentName)) != i:
			i.get_node("TextureButton").button_pressed = false

func update_all():
	var targets = $Slots.get_children()
	for i in targets:
		i.update_items()
		
	

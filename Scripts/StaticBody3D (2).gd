extends StaticBody3D

signal panel_mode()
signal add_panel_instance_to_main()

@onready var interaction_level = 0

@onready var parent = self.get_parent().get_parent().get_parent()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
func interact():
	panel_mode.emit()
	var PanelCamera = parent.get_node("TouchPanel/PanelCamera")
	var PlayerCamera = parent.get_node("Player")
	var pos = PanelCamera.position
	var rot = PanelCamera.rotation
	var ppos = PlayerCamera.position
	ppos.y = ppos.y+1.38
	ppos.x = ppos.x+.1
	PanelCamera.position = ppos
	PanelCamera.rotation = PlayerCamera.rotation
	PanelCamera.current = true
	var tween = get_tree().create_tween()
	tween.tween_property(PanelCamera, "position", pos, 1)
	var tween2 = get_tree().create_tween()
	tween2.tween_property(PanelCamera, "rotation", rot, 1)
	await tween2.finished
	PlayerCamera.process_mode = Node.PROCESS_MODE_DISABLED
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	#get_tree().change_scene_to_file("res://Scenes/panel_mode.tscn")
	emit_signal("add_panel_instance_to_main")
	PanelCamera.current = false
	
		
func get_interact_text():
	return "Operate panel [E]"

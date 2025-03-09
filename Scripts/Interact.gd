extends RayCast3D

@onready var is_paused = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_paused:
		$InteractUI.hide()
		return
	
	var obj = self.get_collider()
	
	if self.is_colliding() and obj.is_in_group("interact"):
		
		if obj.has_method("get_interact_text"):
			$InteractUI/Label.text = obj.get_interact_text()
		else:
			$InteractUI/Label.text = "Press [E] to Interact"
		
		$InteractUI.show()
		if Input.is_action_just_pressed("interact"):
			obj.interact()
	else:
		$InteractUI.hide()

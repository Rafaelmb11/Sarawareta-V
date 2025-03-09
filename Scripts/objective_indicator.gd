extends Node2D

@onready var glob = get_node("/root/globals")

var obj_descriptions = {
	"after_intro_tutorial" : "Go to the big screen at the back of the room and check it out."
	
	
}

func update():
	var obj = glob.Save["CurrentObjective"]
	
	if obj == null:
		self.visible = false
		return
	else:
		self.visible = true
	
	$ObjBox/Contents.text = obj_descriptions[obj]
	
	

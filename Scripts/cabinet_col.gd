extends StaticBody3D

signal textbox_event(contents)
signal enter_storage_mode
@onready var interaction_level = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
func interact():
	if interaction_level == 0:
		emit_signal("textbox_event", ["This is a cabinet... These engravings look lewd.", 
	"... Could there be something useful inside?"])
		interaction_level = interaction_level+1
	else:if interaction_level > 0 && !$OpenSound.playing:
		$OpenSound.play()
		enter_storage_mode.emit()
		
func get_interact_text():
	if interaction_level == 0:
		return "Examine [E]"
	if interaction_level > 0:
		return "Open [E]"

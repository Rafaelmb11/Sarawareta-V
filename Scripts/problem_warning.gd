extends Node2D

@export var DisplayText : String = ""
@onready var originalPos = $Label1.position
@onready var originalMod = $Label1.modulate
@onready var cooldown = Time.get_ticks_msec()
@onready var Label2Use = $Label1
var labelCount = 0
# Called when the node enters the scene tree for the first time.


func roll_text():
	if cooldown > Time.get_ticks_msec():
		return
		
	var allLabels = self.get_children()
	Label2Use = allLabels[labelCount]
	labelCount = labelCount+1
	if labelCount == 6:
		labelCount = 0
	
	Label2Use.position = originalPos
	Label2Use.modulate = originalMod
	Label2Use.text = DisplayText
	
	cooldown = Time.get_ticks_msec() + .2
	
	var tween = get_tree().create_tween()
	
	
	var newpos = Vector2(Label2Use.position.x, Label2Use.position.y-180)
	var newcolor = Color(1.0,1.0,1.0,0)
	tween.tween_property(Label2Use, "position", newpos, 1.2)
	tween.set_parallel()
	tween.tween_property(Label2Use, "modulate", newcolor, 1.2)
	

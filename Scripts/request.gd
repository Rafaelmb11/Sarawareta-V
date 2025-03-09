extends MarginContainer

@export var title : String
@export var sender : String
@export var reward : String
@export var deadline : String = "Unknown"
@export_multiline var requirements : String
@export_multiline var message : String


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$RequestBoxBase_0/ScrollContainer/Message.text = message
	$RequestBoxBase_0/Title.text = title
	$RequestBoxBase_0/Sender.text = sender
	$RequestBoxBase_0/Reward.text = reward
	$RequestBoxBase_0/Requirements.text = requirements
	$RequestBoxBase_0/Deadline2.text = deadline


func _on_accept_button_pressed() -> void:
	$"../../../Scenarios".live_scenario(title+"_accept")


func _on_deny_button_pressed() -> void:
	$"../../../Scenarios".live_scenario(title+"_deny")

extends Node

signal turn_off_input_processing_at_main
signal turn_on_input_processing_at_main

@onready var glob = get_node("/root/globals")
var text
@onready var Textbox = $"../Textbox"
@onready var CharSprite = $"../CharSprite"
@onready var ProtagonistName = glob.ProtagonistName
@onready var HanninName = glob.HanninName

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if glob.Save["PlayWildDialogue"] != null:
		wild_dialogue(glob.Save["PlayWildDialogue"])
		glob.Save["PlayWildDialogue"] = null
		print("Should've played the wild dialogue")
		
func playText(text):
	Textbox.playText(text)

func wild_dialogue(key : String):
	if key == "after_intro_tutorial_0":
		await get_tree().create_timer(1.5).timeout
		Textbox.reset()
		text = [
			HanninName+" | 「Ok then, I'll now explain how you can make money to bail that sexy ass of yours out of here.」",
			HanninName+" | 「First of all, go to that screen in the back of the room!」",
		]
		playText(text)
		await Textbox.finished
		
	if key == "tried_storing_equipped_item":
		Textbox.reset()
		text = [
			ProtagonistName+" | I'm wearing this!",
		]
		playText(text)
		await Textbox.finished
		
	if key == "destination_is_full":
		Textbox.reset()
		playText(ProtagonistName+" | It's full, there's no way this stuff is going in...")
		await Textbox.finished

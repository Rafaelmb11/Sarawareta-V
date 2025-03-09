extends Node3D

@onready var transition = load("res://Scenes/scene_transition.tscn")
@onready var transition_instance = transition.instantiate()
@onready var glob = get_node("/root/globals")
@onready var ProtagonistName = glob.ProtagonistName
@onready var state = "game"
@onready var previousState = state
@onready var config = load("res://Scenes/config.tscn")
@onready var drag_mode = false
@onready var drag_target
@onready var drag_target_is_valid = false
@onready var drag_target_slot
@onready var drag_target_previous_position
@onready var intro_is_playing = false

signal motion_matching(pos : Vector3)

var do_not_process = false

var CONFIG_INSTANCE

signal pop_warning_message
signal play_previous_fade_transition
signal block_player_input
signal unblock_player_input
signal play_elevator_scene
signal play_elevator_back_scene
# Called when the node enters the scene tree for the first time.
func _ready():
	glob.load_from_save.connect(_load_from_save)
	glob.current_player_position_vector = $Player.position
	$CharSprite.updateOutfit()
	self.add_child(transition_instance)
	
	#region Continuation of the intro
	#glob.previousScene = "intro"
	if glob.previousScene == "intro":
		
		$Menu/Button2.disabled = true
		#$RoomView.set_current(true)
		player_process(false)
		#$Player.inactive(true)
		$CharSprite.setEquipment("pajamas_1_v1_bot_blue")
		$CharSprite.setEquipment("pajamas_1_v1_top_blue")
		#$CharSprite.setEquipment("underwear_v1_bra_blue")
		$CharSprite.setEquipment("underwear_v1_panty_blue")
		$CharSprite.preRenderedMode(true)
		$CharSprite.changeExpression("embarrassed")
		$CharSprite.charScale(Vector2(.85,.85))
		$CharSprite.position.y = 800
		$CharSprite.moveTo("middle")
		$CharSprite.visible = true
		$CharSprite.playAnimation("waking")
		do_not_process = true
		state = "intro"
		var text = ["??? | 「…」",
		"??? | 「あれ？ここは…」"
		]
		playText(text)
		await $Textbox.finished
		$CharSprite.changeExpression("frantic")
		$CharSprite.changeBlush(1,1)
		text = [
			"??? | 「もしも…私…誘拐された？…」",
			"??? | 「え？監視カメラ…まさか、取られてるの？」",
			"突然、部屋中に男の声が響いた、犯人の声だった。",
			"犯人 | 「キャハハハハ、おはよう、りりたんと呼ばれるVの中の人さん！」",
			"りりたん？ | 「え？やっぱり、誘拐されたのか…」",
			"犯人 | 「そう！君が誘拐されたんだよ、でー、犯人はこの僕なんだよねー。」"
		]
		playText(text)
		await $Textbox.finished
		$Textbox.reset()
		$CharSprite.changeExpression("frown")
		$CharSprite.changeBlush(1,0)
		text = [
			"りりたん？ | 「あーそう。じゃ、さっさと私を犯してこれを済ませって、どうせ体目当てでしょう、私は暇じゃないから。」",
			"犯人 | 「え？」",
			"犯人 | 「嫌々、僕は、YouKaiと言う凌辱配信サイトを運営しています。あなたのリスナーの一人が金を払たので、君は次の被害者に決めたって事ですね、わかりましたか？」",
			
		]
		playText(text)
		await $Textbox.finished
		$Textbox.reset()
		$CharSprite.changeExpression("frantic")
		text = [
			"言葉の意味に築き、りりたんを演じる少女は恐怖を感じた。",
			"りりたん？ | 「配信って…まさか、私の招待をばらすつもり？」",
			"犯人 | 「あー、もうばらしたぞ、もうライブ配信中です、世界中の人達が見てる、ほら、あの画面を見てごらん。」",
		]
		playText(text)
		await $Textbox.finished
		$Textbox.reset()
		$CharSprite.changeExpression("surprised")
		$CharSprite.changeBlush(1,2)
		text = [
			"りりたん？ | 「え？」",
			"少女は、自分がしていたことが良くないことだとわかっていた。家族や友人にばれたら、逢う顔が無くなる。",
		]
		playText(text)
		await $Textbox.finished
		$Textbox.reset()
		$CharSprite.changeExpression("thinking")
		$CharSprite.changeBlush(1,1)
		text = [
			"りりたん？ | 良い人生だったなー、嫌、良くなかったけど、でも、それも終わりか…自殺方は選ばなきゃね、どうすれば痛くないのかしら…"
		]
		playText(text)
		await $Textbox.finished
		$Textbox.reset()
		$CharSprite.changeExpression("fretting")
		$CharSprite.changeBlush(1,2)
		text = [
			"犯人 | 「それでは、"+ProtagonistName+"さん、今からきみはこの部屋に過ごす事で、エンターテインメントとして、金を稼ぐ。」",
			ProtagonistName+" | 「まさか…あのなすなんとかのような笑いものにされるとか？…」",
			"犯人 | 「ちょっと違うね。君をじっくりといじめたいけど、残念ながら、タイムリミットがある、警察がきみを探してるので、一週間内に済ませます。」",
			ProtagonistName+" | 「じゃ、私を開放する条件とは…」",
			"犯人 | 「そうだね、"+glob.ObjectiveMoney+"と言う額を稼いだらきみを開放します。」",
		]
		playText(text)
		await $Textbox.finished
		$Textbox.reset()
		$CharSprite.changeExpression("surprised")
		$CharSprite.changeBlush(1,1)
		text = [
			ProtagonistName+" | 「なー…ー週刊内にそんな額をかせげるわけないだろう！」",
			"犯人 | 「だろうな。でもね、失敗すれば、きみをリスナーの目の前で犯すんだよー！キャハハハ！」",
		]
		playText(text)
		await $Textbox.finished
		$Textbox.reset()
		$CharSprite.changeExpression("thinking")
		$CharSprite.changeBlush(1,0)
		text = [
			ProtagonistName+" | やっぱり、体目当てじゃん…私の招待はもう…皆の前で犯されたら本当に自殺するしか…",
		]
		playText(text)
		await $Textbox.finished
		
		do_not_process = false
		
		
		var image = get_viewport().get_texture().get_image()
		glob.setImage(image)
		$CharSprite.visible = false
		$Textbox.reset()
		$TransitionManager.previousFade()
		$Player/Head/Camera.set_current(true)
		player_process(true)
		$Menu/Button2.disabled = false
		$CharSprite.preRenderedMode(false)
		state = "game"
		#glob.Save["PlayWildDialogue"] = "after_intro_tutorial_0"
		$Scenarios.wild_dialogue("after_intro_tutorial_0")
	#endregion
	
	#temp shit
	$CharSprite.setEquipment("pajamas_1_v1_bot_blue")
	$CharSprite.setEquipment("pajamas_1_v1_top_blue")
	#$CharSprite.setEquipment("underwear_v1_bra_blue")
	$CharSprite.setEquipment("underwear_v1_panty_blue")
	$CharSprite.preRenderedMode(false)
	#glob.Save["CurrentObjective"] = "after_intro_tutorial"
	state = "game"
	#nigger nigger fag fag nigger

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$ObjectiveIndicator.update()
	
	#$Data.text = "Pos -> "+str($Player.position)
	motion_matching.emit($Player.position)
	
	if $LoadPage.visible == false:
		$LoadPage.process_mode = Node.PROCESS_MODE_DISABLED
	else:
		$LoadPage.process_mode = Node.PROCESS_MODE_INHERIT
		
	if $SavePage.visible == false:
		$SavePage.process_mode = Node.PROCESS_MODE_DISABLED
	else:
		$SavePage.process_mode = Node.PROCESS_MODE_INHERIT
		
	#$TempCam4Prints.set_current(true)
	
	

	if Input.is_action_just_pressed("ui_test"):
		pass
		
		

	if glob.was_loaded_from_save && str($Player.position) != glob.Save["PlayerPosition"]:
		$Player.position = glob.parseString2Vector3(glob.Save["PlayerPosition"])
		$Player/Head/Camera.rotation = glob.parseString2Vector3(glob.Save["PlayerCameraRotation"])
		print("run the thing")
		glob.was_loaded_from_save = false
	
	

	if Input.is_action_just_pressed("printscreen"):
		glob.printScreen()
		
	
	if !do_not_process:
	
		if Input.is_action_just_pressed("ui_inventory") && (state == "game" || state == "inventory"):
			if state == "inventory":
				$Inventory.visible = false
				state = "game"
				#$Inventory/CharSprite.visible = false
				$Inventory.update_all()
				return
			if state == "game":
				state = "inventory"
				#$Inventory/CharSprite.visible = true
				$Inventory.visible = true
				$Inventory.update_all()
				return
			
		
		if Input.is_action_just_pressed("ui_cancel"):
			
			
			if state == "panel_mode" && !glob.panel_scenario_is_playing:
				state = "game"
				glob.isPanelMode = false
				$PanelMode.visible = false
				if !glob.Save["ItemBox"].is_empty():
					emit_signal("play_elevator_scene")
				return
				
			if state == "storage":
				state = "game"
				$Storage.visible = false
				return
				
			if state == "inventory":
				state = "game"
				#$Inventory/CharSprite.visible = false
				$Inventory.visible = false
				return
			
			if state == "menu":
				$Menu.visible = false
				state = "game"
				return
				
			if state != "game" && state != "menu" && !glob.panel_scenario_is_playing:
				self.remove_child(CONFIG_INSTANCE)
				$SavePage.visible = false
				$LoadPage.visible = false
				$Menu.visible = true
				state = "menu"
				return
				
			if state == "game" && !$Textbox.visible:
				var temp_img = get_viewport().get_texture().get_image()
				glob.thumb_holder = temp_img
				glob.current_player_position = str($Player.position)
				glob.current_player_position_vector = $Player.position
				glob.current_player_rotation = str($Player/Head/Camera.rotation)
				$Menu.visible = true
				state = "menu"
				return
				
	
	
		
	if $Textbox.visible || $Menu.visible || $Inventory.visible || $PanelMode.visible || $Storage.visible || glob.PlayingMovie:
		player_process(false)
	else:
		player_process(true)
		
		
	
	glob.game_state = state
	
	
	
func playText(text):
	$Textbox.playText(text)
	
	
func _on_menu_resume_game():
	state = previousState
	$Menu.visible = false


func _on_menu_save_game():
	$SavePage.visible = true
	state = "save"


func _on_save_page_back_to_menu():
	$SavePage.visible = false
	$Menu.visible = true
	state = "menu"


func _on_menu_config_page():
	CONFIG_INSTANCE = config.instantiate()
	self.add_child(CONFIG_INSTANCE)
	state = "config"


func _on_menu_exit_game():
	get_tree().quit()


func _on_menu_go_to_title():
	get_tree().change_scene_to_file("res://Scenes/TitleScreen.tscn")


func _on_menu_load_game():
	$LoadPage.visible = true
	state = "load"


func _on_load_page_back_to_menu():
	$LoadPage.visible = false
	$Menu.visible = true
	state = "menu"
	
func _load_from_save():
	print("load from save was run")
	glob.was_loaded_from_save = true
	$Player.position = glob.parseString2Vector3(glob.Save["PlayerPosition"])
	$Player/Head/Camera.rotation = glob.parseString2Vector3(glob.Save["PlayerCameraRotation"])
	
func _get_off_the_ui():
	if state != "game":
			self.remove_child(CONFIG_INSTANCE)
			$SavePage.visible = false
			$LoadPage.visible = false
			$Menu.visible = false
			state = "game"
			

func player_process(value : bool):
	if value:
		$Player.process_mode = Node.PROCESS_MODE_PAUSABLE
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		$Player/Head/Camera/Interact/InteractUI.visible = true
		$Player/Crosshair.visible = true
		$Player/Info.visible = true
	else:
		$Player.process_mode = Node.PROCESS_MODE_DISABLED
		if !$Textbox.visible && !glob.PlayingMovie:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		$Player/Head/Camera/Interact/InteractUI.visible = false
		$Player/Crosshair.visible = false
		$Player/Info.visible = false

func _on_static_body_3d_add_panel_instance_to_main() -> void:
	state = "panel_mode"
	player_process(false)
	glob.isPanelMode = true
	$PanelMode.visible = true
	

func _on_box_get_items_from_box() -> void:
	var all_slots = $Inventory/Slots.get_children()
	for i in all_slots:
		if i.isEmpty && !glob.Save["ItemBox"].is_empty():
			i.set_item(glob.Save["ItemBox"].pop_front())
			
	if !glob.Save["ItemBox"].is_empty():
		$ProblemWarning.DisplayText = "Inventory is full!"
		$ProblemWarning.roll_text()
		
	if glob.Save["ItemBox"].is_empty():
		$Room/Elevator2/box.visible = false
		$Room/Elevator2/box/AudioStreamPlayer3D
		play_elevator_back_scene.emit()


func _on_cabinet_col_enter_storage_mode() -> void:
	state = "storage"
	$Storage.visible = true
	player_process(false)
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	var update_targets = $Storage/Slots.get_children()
	update_targets.append($Storage/Slots2.get_children())
	for i in update_targets:
		i.update_items()

extends CanvasLayer

@export var FontSize : int = 38
@export var SpeakerFontSize : int = 42
@onready var glob = get_node("/root/globals")
@onready var textbox_container = $TextboxContainer
@onready var LabelHndw = $TextboxContainer/MarginContainer/HBoxContainer/Label
@onready var text_queue
@onready var speed = (((glob.config.get_value("Config", "text_speed")-100)*-1)/100)/5
@onready var readSpeed = null
@onready var temp = get_tree().create_tween()
@onready var cooldown = 100
@onready var block_input_till = 0
@onready var alwaysVisible = false
@onready var textOnDisplay = ""
@onready var previousTextOnDisplay = ""
@onready var skipCD = 35
@onready var holdSkipTargetCD = Time.get_ticks_msec()
@onready var skipMode = false
@onready var isVisible = true
@onready var isFinished = true
@onready var previousIsFinished = true
signal finished
signal kill_the_tween


# Called when the node enters the scene tree for the first time.
func _ready():
	if get_parent().name == "Config":
		alwaysVisible = true
	hide_textbox()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if !self.visible:
		return
	
	$Speaker.add_theme_font_size_override("font_size", SpeakerFontSize)
	$TextboxContainer/MarginContainer/HBoxContainer/Label.add_theme_font_size_override("font_size", FontSize)
	
	$TextboxContainer/Sprite2D.modulate = glob.TextboxColor
	$TextboxContainer/Sprite2D.self_modulate = glob.TextboxColor
	
	if text_queue != null && text_queue.is_empty():
		isFinished = true
		hide_textbox()
	else:
		isFinished = false
		
	if isFinished && !previousIsFinished:
		finished.emit()
		
		
	previousIsFinished = isFinished
	
	
	if skipMode || (cooldown_check() && Input.is_action_just_pressed("ui_accept") && LabelHndw.visible_ratio > 0.99):
		temp.custom_step(0.0)
		LabelHndw.visible_ratio = 0.0
		if text_queue == null:
			return
		displaytxt(text_queue.pop_front())
		block_input_till = Time.get_ticks_msec() + cooldown
		
	
	if skipMode || (cooldown_check() && Input.is_action_just_pressed("ui_accept") && LabelHndw.visible_ratio < 1.0):
		temp.custom_step(10.0)
		LabelHndw.visible_ratio = 1.0
		block_input_till = Time.get_ticks_msec() + cooldown
		
	simulateEnterOnTimer(skipCD)
		
		

func cooldown_check():
	if Time.get_ticks_msec() > block_input_till:
		return true
	else:
		return false

func displaytxt(txt):
	if txt == null:
		return
	if txt.contains(" | "):
		var splitedtxt = txt.split(" | ")
		$Speaker.text = "【"+splitedtxt[0]+"】"
		txt = splitedtxt[1]
	else:
		$Speaker.text = ""
	previousTextOnDisplay = LabelHndw.text
	LabelHndw.text = txt
	textOnDisplay = txt
	print(str(txt.length) +" "+ str(speed))
	readSpeed = txt.length() * speed
	readSpeed = clamp(readSpeed, 0.2, 5)
	var tween = get_tree().create_tween()
	print(str(readSpeed))
	tween.tween_property(LabelHndw, "visible_ratio", 1.0, readSpeed)
	temp.kill()
	temp = tween
	#await tween.finished
		
	
func hide_textbox():
	LabelHndw.text = ""
	if alwaysVisible:
		return
	self.visible = false
	$Speaker.visible = false
	

func show_textbox():
	self.visible = true
	$Speaker.visible = true
	

func _on_static_body_3d_textbox_event(contents):
	playText(contents)
	
func playText(Text):
	LabelHndw.visible_ratio = 0.0
	var handled_text = Text
	if Text is String:
		handled_text = [Text]
		
	handled_text.append("")
	text_queue = handled_text
	show_textbox()
	if text_queue[0].is_empty():
		text_queue.pop_front()
	var text2display = text_queue.pop_front()
	readSpeed = text2display.length() * speed
	displaytxt(text2display)
		
func isAlwaysVisible(tog : bool):
	alwaysVisible = tog
	
func setColor(color : Color):
	$TextboxContainer/Sprite2D.modulate = color
	$TextboxContainer/Sprite2D.self_modulate = color
	
func getDisplayedText():
	return textOnDisplay
	
func getPreviousTextOnDisplay():
	return previousTextOnDisplay
	
func simulateEnterOnTimer(delay : int):
	if Time.get_ticks_msec() > holdSkipTargetCD && Input.is_action_pressed("skip_hold"):
		skipMode = true
		holdSkipTargetCD = Time.get_ticks_msec() + delay
	else:
		skipMode = false
		
func reset():
	temp.kill()
	LabelHndw.text = ""
	LabelHndw.visible_ratio = 0

extends CanvasLayer

signal back_pressed
@onready var Globals = load("res://Scripts/Globals.gd").new()
@onready var glob = get_node("/root/globals")
@onready var Sliders = {
	"Master Volume": $MasterVolume,
	"BGM Volume": $BGMVolume,
	"SFX Volume": $SFXVolume,
	"System SFX Volume": $SystemSFXVolume,
	"Voice Volume": $VoiceVolume,
	"Text Speed": $TextSpeed,
	"Textbox Transparency": $TextboxTransparency,
	"Auto Mode Speed": $AutoModeSpeed,
	
}

# Called when the node enters the scene tree for the first time.
func _ready():
	for key in Sliders:
		var temp = Sliders[key]
		temp.get_child(1).text = Globals.TranslationWrapper(key)
	$MasterVolume.value = glob.config.get_value("Config", "master_volume")
	$BGMVolume.value = glob.config.get_value("Config", "bgm_volume")
	$SFXVolume.value = glob.config.get_value("Config", "sfx_volume")
	$SystemSFXVolume.value = glob.config.get_value("Config", "system_volume")
	$VoiceVolume.value = glob.config.get_value("Config", "voice_volume")
	$TextSpeed.value = glob.config.get_value("Config", "text_speed")
	$AutoModeSpeed.value = glob.config.get_value("Config", "automode_speed")
	_on_timer_timeout()
	$ColorPicker.color = glob.config.get_value("Config", "textbox_color", Color.BLACK)
	$SkipUnreadText/SkipUnreadText.button_pressed = glob.config.get_value("Config", "skip_unread", false)
	$MosaicCensor/MosaicCensor.button_pressed = glob.config.get_value("Config", "mosaics", false)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_timer_timeout():
	if !self.visible:
		$Textbox.visible = false
		print("Textbox visibility was set to "+str($Textbox.visible))
		$Textbox.process_mode = Node.PROCESS_MODE_DISABLED
		return
	$Textbox.visible = true
	$Textbox.process_mode = Node.PROCESS_MODE_ALWAYS
	print("Textbox visibility was set to "+str($Textbox.visible))
	var txt = [
		"This is some sample text for config evaluation...",
		"This is some sample text for config evaluation...",
	]
	#$Textbox._on_static_body_3d_textbox_event(txt)
	$Textbox.playText("This is some sample text for config evaluation...")
	var ui_accept = InputEventAction.new()
	ui_accept.action = "ui_accept"
	ui_accept.pressed = true
	Input.parse_input_event(ui_accept)

func _on_title_pressed():
	get_tree().change_scene_to_file("res://Scenes/TitleScreen.tscn")

func _on_exit_pressed():
	get_tree().quit()

func _on_color_picker_color_changed(color):
	glob.TextboxColor = color
	var temp = Color(color)
	$Textbox.setColor(color)
	glob.config.set_value("Config", "textbox_color", color)
	glob.config.save(glob.ConfigPath)

func _on_master_volume_value_changed(value):
	$MasterVolume/Ratio.text = str(value)
	glob.config.set_value("Config", "master_volume", value)

func _on_master_volume_drag_ended(value_changed):
	glob.config.save(glob.ConfigPath)

func _on_bgm_volume_value_changed(value):
	$BGMVolume/Ratio.text = str(value)
	glob.config.set_value("Config", "bgm_volume", value)

func _on_bgm_volume_drag_ended(value_changed):
	glob.config.save(glob.ConfigPath)

func _on_sfx_volume_drag_ended(value_changed):
	glob.config.save(glob.ConfigPath)

func _on_sfx_volume_value_changed(value):
	$SFXVolume/Ratio.text = str(value)
	glob.config.set_value("Config", "sfx_volume", value)

func _on_system_sfx_volume_value_changed(value):
	$SystemSFXVolume/Ratio.text = str(value)
	glob.config.set_value("Config", "system_volume", value)

func _on_system_sfx_volume_drag_ended(value_changed):
	glob.config.save(glob.ConfigPath)

func _on_voice_volume_value_changed(value):
	$VoiceVolume/Ratio.text = str(value)
	glob.config.set_value("Config", "voice_volume", value)

func _on_voice_volume_drag_ended(value_changed):
	glob.config.save(glob.ConfigPath)
	
func _on_text_speed_value_changed(value):
	$TextSpeed/Ratio.text = str(value)
	glob.config.set_value("Config", "text_speed", value)

func _on_text_speed_drag_ended(value_changed):
	glob.config.save(glob.ConfigPath)

func _on_auto_mode_speed_value_changed(value):
	$AutoModeSpeed/Ratio.text = str(value)
	glob.config.set_value("Config", "automode_speed", value)

func _on_check_box_toggled(toggled_on):
	glob.config.set_value("Config", "skip_unread", toggled_on)
	glob.config.save(glob.ConfigPath)

func _on_mosaic_censor_toggled(toggled_on):
	glob.config.set_value("Config", "mosaics", toggled_on)
	glob.config.save(glob.ConfigPath)


func _on_back_pressed():
	self.visible = false

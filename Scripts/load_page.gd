extends CanvasLayer

signal back_to_menu
signal get_off_the_ui
@onready var glob = get_node("/root/globals")

@onready var cooldowns = {
	"update_thumbs" = 0,
	"update_time" = 0
	}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	updateThumbs()
	updateDateTime()

func _on_next_page_pressed():
	if int($PageNumber.text) != 9:
		$PageNumber.text = str(int($PageNumber.text) + 1)
		updateThumbs()
		updateDateTime()
	else:
		$PageNumber.text = str(1)
		updateThumbs()
		updateDateTime()

func _on_previous_page_pressed():
	if int($PageNumber.text) != 1:
		$PageNumber.text = str(int($PageNumber.text) - 1)
		updateThumbs()
		updateDateTime()
	else:
		$PageNumber.text = str(9)
		updateThumbs()
		updateDateTime()
	
func _on_exit_pressed():
	get_tree().quit()

func _on_title_pressed():
	get_tree().change_scene_to_file("res://Scenes/TitleScreen.tscn")

func _on_slot_1_pressed():
	var slot = 1+((int($PageNumber.text)-1)*9)
	var image = get_viewport().get_texture().get_image() # We get what our player sees
	glob.setImage(image)
	glob.load_from_file(slot)
	handle_loading_shit()

func _on_slot_2_pressed():
	var slot = 2+((int($PageNumber.text)-1)*9)
	var image = get_viewport().get_texture().get_image() # We get what our player sees
	glob.setImage(image)
	glob.load_from_file(slot)
	handle_loading_shit()

func _on_slot_3_pressed():
	var slot = 3+((int($PageNumber.text)-1)*9)
	var image = get_viewport().get_texture().get_image() # We get what our player sees
	glob.setImage(image)
	glob.load_from_file(slot)
	handle_loading_shit()

func _on_slot_4_pressed():
	var slot = 4+((int($PageNumber.text)-1)*9)
	var image = get_viewport().get_texture().get_image() # We get what our player sees
	glob.setImage(image)
	glob.load_from_file(slot)
	handle_loading_shit()

func _on_slot_5_pressed():
	var slot = 5+((int($PageNumber.text)-1)*9)
	var image = get_viewport().get_texture().get_image() # We get what our player sees
	glob.setImage(image)
	glob.load_from_file(slot)
	handle_loading_shit()

func _on_slot_6_pressed():
	var slot = 6+((int($PageNumber.text)-1)*9)
	var image = get_viewport().get_texture().get_image() # We get what our player sees
	glob.setImage(image)
	glob.load_from_file(slot)
	handle_loading_shit()

func _on_slot_7_pressed():
	var slot = 7+((int($PageNumber.text)-1)*9)
	var image = get_viewport().get_texture().get_image() # We get what our player sees
	glob.setImage(image)
	glob.load_from_file(slot)
	handle_loading_shit()

func _on_slot_8_pressed():
	var slot = 8+((int($PageNumber.text)-1)*9)
	var image = get_viewport().get_texture().get_image() # We get what our player sees
	glob.setImage(image)
	glob.load_from_file(slot)
	handle_loading_shit()

func _on_slot_9_pressed():
	var slot = 9+((int($PageNumber.text)-1)*9)
	var image = get_viewport().get_texture().get_image() # We get what our player sees
	glob.setImage(image)
	glob.load_from_file(slot)
	handle_loading_shit()

func _on_back_pressed():
	emit_signal("back_to_menu")
	self.visible = false

func updateThumbs():
	if !self.visible or cooldowns["update_thumbs"] >= glob.get_ellapsed_time_in_ms():
		return
		
	cooldowns["update_thumbs"] = glob.get_ellapsed_time_in_ms()+500
	
	print("Thumb was updated")
	
	for i in range(9):
		var slot = (i+1)+((int($PageNumber.text)-1)*9)
		var slotAccess = i+1
		var thumbImg = glob.load_external_img(glob.SAVE_THUMBS_PATH+str(slot)+".jpg")
		if thumbImg != null:
			var node = get_node("Slot"+str(slotAccess)+"/Thumb")
			node.texture = ImageTexture.create_from_image(thumbImg)
		else:
			var node = get_node("Slot"+str(slotAccess)+"/Thumb")
			if node != null:
				node.texture = null
			
func updateDateTime():
	if !self.visible or cooldowns["update_time"] >= glob.get_ellapsed_time_in_ms():
		return
		
	cooldowns["update_time"] = glob.get_ellapsed_time_in_ms()+500
	print("Time was updated")
		
	for i in range(9):
		var slot = (i+1)+((int($PageNumber.text)-1)*9)
		var slotAccess = i+1
		var save = JSON.parse_string(glob.getSaveSlot(str(slot)))
		var date = get_node("Slot"+str(slotAccess)+"/Date")
		var time = get_node("Slot"+str(slotAccess)+"/Time")
		if save == null:
			slot = null
			save = null
			date = null
			time = null
			return
			
		for key in save:
			if key == "Date":
				date.text = save["Date"]
				
			if key == "Time":
				time.text = save["Time"]
				
func handle_loading_shit():
		glob.was_loaded_from_save = true
		get_off_the_ui.emit()

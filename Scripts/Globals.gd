extends Node

class_name Globals

signal load_from_save
@onready var userDir = DirAccess.open("user://")
@onready var previousSceneImgPath = "user://temp/previousSceneImage.jpg"
var game_state
var MakerName = "MakerName"
var GameName = "Sarawareta V"
var idiom = "English"
var ProtagonistName = "水島由香"
var HanninName = "Mr.Perv"
var ObjectiveMoney = "1000000USD"
var SaveFilePath = ""
var ConfigPath = ""
var config = ConfigFile.new()
var TextboxColor
var holdImage = null
var previousScene = "menu"
var thumb_holder
@onready var PlayingMovie = false
const SAVE_PATH: String = "user://save_data.sav"
const SAVE_PASS: String = "MAGA"
const SAVE_THUMBS_PATH = "user://thumbs/"
const SAVE_PRINTS_PATH = "user://printscreens/"
var was_loaded_from_save = false
var current_player_position
var current_player_position_vector
var current_player_rotation
var panel_scenario_is_playing = false
var Save = {
	"Slot" : 1,
	"Date" : "",
	"Time" : "",
	"Money" : 5000,
	"PlayerPosition" : "",
	"PlayerCameraRotation" : "",
	"ItemBox" : [],
	"Slot1" : "pajamas_1_v1_top_blue",
	"Slot2" : "pajamas_1_v1_bot_blue",
	"Slot3" : "underwear_v1_bra_blue",
	"Slot4" : "underwear_v1_panty_blue",
	"Clothes" : {"BehindBody" : null, "BaseBody" : null, "Booba" : null, "Pubic_hair" : null, "OnePieceUnderwear" : null, "Bra" : "underwear_v1_bra_blue", "Panty" : "underwear_v1_panty_blue", "OnePiece" : null, "Top" : "pajamas_1_v1_top_blue", "Bot" : "pajamas_1_v1_bot_blue", "Accessory" : null, "Accessory2" : null, "Accessory3" : null},
	"CurrentObjective" : null,
	"PlayWildDialogue" : null,
	"random_chat_odds" : 4,
	"TempFlag" : null,
	"FirstTimeUsingPanelMode" : false,
}


var isPanelMode = false

func _ready():
	SaveFilePath = OS.get_executable_path().get_base_dir() + "/Save.ini"
	ConfigPath = OS.get_executable_path().get_base_dir() + "/Config.cfg"
	config = ConfigFile.new()
	#DefaultConfigFile(config)
	var err = config.load(ConfigPath)
	if err != OK:
		DefaultConfigFile(config)
		
	if !userDir.dir_exists("temp"):
		userDir.make_dir_recursive("temp")
	
	
	
	
	TextboxColor = config.get_value("Config", "textbox_color")

	

func TranslationWrapper(Text : String):
	return Text
	
func save_thumb(slot):
	var thumbsDir = DirAccess.open("user://")
	if !userDir.dir_exists("thumbs"):
		userDir.make_dir_recursive("thumbs")
	if thumb_holder != null:
		thumb_holder.save_jpg(SAVE_THUMBS_PATH+slot+".jpg", 0.25)
		
		
	
func DefaultConfigFile(config : ConfigFile):
	config.set_value("Config", "master_volume", 100)
	config.set_value("Config", "bgm_volume", 100)
	config.set_value("Config", "sfx_volume", 100)
	config.set_value("Config", "voice_volume", 100)
	config.set_value("Config", "system_volume", 100)
	config.set_value("Config", "textbox_transparency", 50)
	config.set_value("Config", "text_speed", 50)
	config.set_value("Config", "automode_speed", 50)
	config.set_value("Config", "mosaics", false)
	config.set_value("Config", "skip_unread", false)
	config.set_value("Config", "textbox_color", Color(0,0,0,1))
	config.save(ConfigPath)
	print("Created config at "+ConfigPath)

func setImage(img):
	holdImage = img
	
func save_to_file(slot : int):
	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	
	var temp = file.get_as_text()
	
	#file.close()
	
	file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	
	var data = JSON.stringify(Save)
	
	var str = getSaveToReplace(temp, slot)
	print("The replaced string is: "+str)
	print("The replacement string is: "+data)
	if !str.is_empty():
		temp = temp.replace(str, data)
	else:
		temp = temp + "\n" + data
	
	print(str(temp))
	#print(data)
	
	file.store_string(temp)
	file.close()
	
func load_from_file(slot):
	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	var temp = file.get_as_text()
	var str = getSaveToReplace(temp, slot)
	print("The new save is "+str)
	Save = JSON.parse_string(str)
	if get_tree().current_scene.name != "Main":
		get_tree().change_scene_to_file("res://main.tscn")
	load_from_save.emit()
	
	
func deleteSaveSlot(text : String, slot : int):
	var lines = Array(text.split("\n"))
	print(str(lines.size())+" lines")
	var str = ""
	for i in range(lines.size()):
		if lines[i] == "\n":
			lines.pop_at(i)
		print(lines[i])
		if lines[i].contains("\"Slot\":"+str(slot)+"}") || lines[i].contains("\"Slot\":"+str(slot)+","):
			str(lines.pop_at(i))
			print("Old slot was removed")
			for j in range(lines.size()):
				str = ""+lines[j]+"\n"
		return str
	return text
	
func getSaveToReplace(text : String, slot : int):
	var lines = Array(text.split("\n"))
	var str = ""
	for i in range(lines.size()):
		if lines[i].contains("\"Slot\":"+str(slot)+"}") || lines[i].contains("\"Slot\":"+str(slot)+","):
			return lines[i]
	return ""
	
func load_external_img(path):
	if !userDir.file_exists(path):
		return
	var image = Image.load_from_file(path)
	#image.compress(3)
	return image
	
func getSaveSlot(slot : String):
	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	var text = file.get_as_text()
	var lines = text.split("\n")
	for i in range(lines.size()):
		if lines[i].contains("\"Slot\":"+str(slot)+"}") || lines[i].contains("\"Slot\":"+str(slot)+","):
			return lines[i]
	return ""
	
func printScreen():
	var printsDir = DirAccess.open("user://")
	if !userDir.dir_exists("printscreens"):
		userDir.make_dir_recursive("printscreens")
	var image = get_viewport().get_texture().get_image()
	var datetime = Time.get_datetime_string_from_system().replace(".","_").replace(":","")
	var path:String = str(SAVE_PRINTS_PATH+"screenshot_"+datetime+".png")
	image.save_png(path)
	
func parseString2Vector3(str : String):
	str = str.replace("(","").replace(")","")
	var arr = str.split(", ")
	var temp = str(Vector3(float(arr[0]),float(arr[1]),float(arr[2])))
	print("The result: "+temp)
	return Vector3(float(arr[0]),float(arr[1]),float(arr[2]))

func get_current_scene():
	return get_tree().current_scene.name
	
func get_item(item : String):
	var items = {
		#Food
		"Butter" : {"ItemType" : "Food", "ItemName" : "Butter", "DisplayName" : "Butter", "ItemThumb" : "res://Icons/180x180/Butter.png", "ItemDescription" : "Glistening with a layer of guilt, it taunts the arteries with every ounce.", "ItemGroups" : "Eatable, Usable, Discardable"},
		"Bread" : {"ItemType" : "Food", "ItemName" : "Bread", "DisplayName" : "Bread", "ItemThumb" : "res://Icons/180x180/Bread.png", "ItemDescription" : "A crunchy delicious mass of sinful carbs.", "ItemGroups" : "Eatable, Discardable"},
		"Burger" : {"ItemType" : "Food", "ItemName" : "Burger", "DisplayName" : "Burger", "ItemThumb" : "res://Icons/180x180/Burger.png", "ItemDescription" : "A classic favourite for every fat fuck out there!", "ItemGroups" : "Eatable, Discardable"},
		"Broccoli" : {"ItemType" : "Food", "ItemName" : "Broccoli", "DisplayName" : "Broccoli", "ItemThumb" : "res://Icons/180x180/Broccoli.png", "ItemDescription" : "You can almost hear it cackling, an evil mastermind of the vegetable world. This is not food for humans!", "ItemGroups" : "Eatable, Discardable"},
		#Equipment
		"dress_1_v1" : {"ItemType" : "Clothing", "ItemName" : "dress_1_v1", "DisplayName" : "Witchy Dress", "ItemThumb" : "res://Icons/180x180/dress_1_v1.png", "ItemDescription" : "Comes with a charm spell. They might spill out at any moment...", "ItemGroups" : "Equipable", "CleavageType" : "Uncompressed", "RenderLayer" : 3, "ClothingType" : "OnePiece", "AllowPanty" : true, "AllowBra" : false, "AllowBot" : false, "AllowTop" : false},
		"dress_2_v1" : {"ItemType" : "Clothing", "ItemName" : "dress_2_v1", "DisplayName" : "China Dress (kinda)", "ItemThumb" : "res://Icons/180x180/dress_2_v1.png", "ItemDescription" : "A more fashionable version of the china dress. Must be used with no underwear!", "ItemGroups" : "Equipable", "CleavageType" : "Uncompressed", "RenderLayer" : 3, "ClothingType" : "OnePiece", "AllowPanty" : false, "AllowBra" : false, "AllowBot" : false, "AllowTop" : false},
		"towel_white" : {"ItemType" : "Clothing", "ItemName" : "towel_white", "DisplayName" : "Bath towel (White)", "ItemThumb" : "res://Icons/180x180/towel_white.png", "ItemDescription" : "It absorbs fluids.", "ItemGroups" : "Equipable", "CleavageType" : "Compressed", "RenderLayer" : 3, "ClothingType" : "OnePiece", "AllowPanty" : false, "AllowBra" : false, "AllowBot" : false, "AllowTop" : false},
		"towel_pink" : {"ItemType" : "Clothing", "ItemName" : "towel_pink", "DisplayName" : "Bath towel (Pink)", "ItemThumb" : "res://Icons/180x180/towel_pink.png", "ItemDescription" : "It absorbs fluids.", "ItemGroups" : "Equipable", "CleavageType" : "Compressed", "RenderLayer" : 3, "ClothingType" : "OnePiece", "AllowPanty" : false, "AllowBra" : false, "AllowBot" : false, "AllowTop" : false},
		"towel_blue" : {"ItemType" : "Clothing", "ItemName" : "towel_blue", "DisplayName" : "Bath towel (Blue)", "ItemThumb" : "res://Icons/180x180/towel_blue.png", "ItemDescription" : "It absorbs fluids.", "ItemGroups" : "Equipable", "CleavageType" : "Compressed", "RenderLayer" : 3, "ClothingType" : "OnePiece", "AllowPanty" : false, "AllowBra" : false, "AllowBot" : false, "AllowTop" : false},
		"gym_1_v1_bot_navy_blue" : {"ItemType" : "Clothing", "ItemName" : "gym_1_v1_bot_navy_blue", "DisplayName" : "Buruma", "ItemThumb" : "res://Icons/180x180/gym_1_v1_bot_navy_blue.png", "ItemDescription" : "Why were they banned??? #BringBurumaBack", "ItemGroups" : "Equipable", "CleavageType" : "Ignore", "RenderLayer" : 3, "ClothingType" : "Bot", "AllowPanty" : true, "AllowBra" : true, "AllowBot" : false, "AllowTop" : true},
		"gym_1_v1_top_blue" : {"ItemType" : "Clothing", "ItemName" : "gym_1_v1_top_blue", "DisplayName" : "Gym Shirt", "ItemThumb" : "res://Icons/180x180/gym_1_v1_top_blue.png", "ItemDescription" : "A shirt that reveals the belly, only forgiven to skinny girls with big boobs.", "ItemGroups" : "Equipable", "CleavageType" : "Compressed", "RenderLayer" : 3, "ClothingType" : "Top", "AllowPanty" : true, "AllowBra" : true, "AllowBot" : true, "AllowTop" : false},
		"hotpants_1_v1_blue" : {"ItemType" : "Clothing", "ItemName" : "hotpants_1_v1_blue", "DisplayName" : "Hot Pants (Blue)", "ItemThumb" : "res://Icons/180x180/hotpants_1_v1_blue.png", "ItemDescription" : "A classic piece of female summer clothing designed to allure men.", "ItemGroups" : "Equipable", "CleavageType" : "Ignore", "RenderLayer" : 3, "ClothingType" : "Bot", "AllowPanty" : true, "AllowBra" : true, "AllowBot" : false, "AllowTop" : true},
		"hotpants_1_v1_pink" : {"ItemType" : "Clothing", "ItemName" : "hotpants_1_v1_pink", "DisplayName" : "Hot Pants (Pink)", "ItemThumb" : "res://Icons/180x180/hotpants_1_v1_pink.png", "ItemDescription" : "Very inviting shorts, any girl who puts this on wants to get raped.", "ItemGroups" : "Equipable", "CleavageType" : "Ignore", "RenderLayer" : 3, "ClothingType" : "Bot", "AllowPanty" : true, "AllowBra" : true, "AllowBot" : false, "AllowTop" : false},
		"hotpants_1_v1_black" : {"ItemType" : "Clothing", "ItemName" : "hotpants_1_v1_black", "DisplayName" : "Hot Pants (Black)", "ItemThumb" : "res://Icons/180x180/hotpants_1_v1_black.png", "ItemDescription" : "It says \"Just rape me already!\"", "ItemGroups" : "Equipable", "CleavageType" : "Ignore", "RenderLayer" : 3, "ClothingType" : "Bot", "AllowPanty" : true, "AllowBra" : true, "AllowBot" : false, "AllowTop" : false},
		"lewd_nazi_military_uniform_v1" : {"ItemType" : "Clothing", "ItemName" : "lewd_nazi_military_uniform_v1", "DisplayName" : "Military Uniform", "ItemThumb" : "res://Icons/180x180/lewd_nazi_military_uniform_v1.png", "ItemDescription" : "A military outfit (cosplay), comes with a special armband!", "ItemGroups" : "Equipable", "CleavageType" : "Compressed", "RenderLayer" : 3, "ClothingType" : "OnePiece", "AllowPanty" : false, "AllowBra" : false, "AllowBot" : false, "AllowTop" : false},
		"micro_bikini_1_v1_top_white" : {"ItemType" : "Clothing", "ItemName" : "micro_bikini_1_v1_top_white", "DisplayName" : "Micro Bikini Top (White)", "ItemThumb" : "res://Icons/180x180/micro_bikini_1_v1_top_white.png", "ItemDescription" : "A swimsuit just in name, if you try to swim on this it'll fall off.", "ItemGroups" : "Equipable", "CleavageType" : "Uncompressed", "RenderLayer" : 2, "ClothingType" : "Bra", "AllowPanty" : true, "AllowBra" : false, "AllowBot" : true, "AllowTop" : true},
		"micro_bikini_1_v1_bot_white" : {"ItemType" : "Clothing", "ItemName" : "micro_bikini_1_v1_bot_white", "DisplayName" : "Micro Bikini Bottom (White)", "ItemThumb" : "res://Icons/180x180/micro_bikini_1_v1_bot_white.png", "ItemDescription" : "A swimsuit just in name, if you try to swim on this it'll fall off.", "ItemGroups" : "Equipable", "CleavageType" : "Ignore", "RenderLayer" : 2, "ClothingType" : "Panty", "AllowPanty" : false, "AllowBra" : true, "AllowBot" : true, "AllowTop" : true},
		"pajamas_1_v1_bot_blue" : {"ItemType" : "Clothing", "ItemName" : "pajamas_1_v1_bot_blue", "DisplayName" : "Yuka's Pajama Bottom", "ItemThumb" : "res://Icons/180x180/pajamas_1_v1_bot_blue.png", "ItemDescription" : "A piece of Yuka's favourite sleepwear, she never intended to be seen wearing it.", "ItemGroups" : "Equipable", "CleavageType" : "Ignore", "RenderLayer" : 3, "ClothingType" : "Bot", "AllowPanty" : true, "AllowBra" : true, "AllowBot" : false, "AllowTop" : false},
		"pajamas_1_v1_top_blue" : {"ItemType" : "Clothing", "ItemName" : "pajamas_1_v1_top_blue", "DisplayName" : "Yuka's Pajama Top", "ItemThumb" : "res://Icons/180x180/pajamas_1_v1_top_blue.png", "ItemDescription" : "A piece of Yuka's favourite sleepwear, she never intended to be seen wearing it.", "ItemGroups" : "Equipable", "CleavageType" : "Compressed", "RenderLayer" : 3, "ClothingType" : "Top", "AllowPanty" : true, "AllowBra" : true, "AllowBot" : true, "AllowTop" : false},
		"shirt_1_v1_white" : {"ItemType" : "Clothing", "ItemName" : "shirt_1_v1_white", "DisplayName" : "Fancy Shirt", "ItemThumb" : "res://Icons/180x180/shirt_1_v1_white.png", "ItemDescription" : "A fancy casual shirt, this model is often used by women named Karen.", "ItemGroups" : "Equipable", "CleavageType" : "Compressed", "RenderLayer" : 3, "ClothingType" : "Top", "AllowPanty" : true, "AllowBra" : true, "AllowBot" : true, "AllowTop" : false},
		"sukumizu_1_v1_navy_blue" : {"ItemType" : "Clothing", "ItemName" : "sukumizu_1_v1_navy_blue", "DisplayName" : "School Swimsuit", "ItemThumb" : "res://Icons/180x180/sukumizu_1_v1_navy_blue.png", "ItemDescription" : "Swimsuit for school girls, considered sexier than the micro bikini by many.", "ItemGroups" : "Equipable", "CleavageType" : "Compressed", "RenderLayer" : 2, "ClothingType" : "UnderwearOnePiece", "AllowPanty" : false, "AllowBra" : false, "AllowBot" : false, "AllowTop" : false},
		"underwear_v1_bra_blue" : {"ItemType" : "Clothing", "ItemName" : "underwear_v1_bra_blue", "DisplayName" : "Yuka's Bra", "ItemThumb" : "res://Icons/180x180/underwear_v1_bra_blue.png", "ItemDescription" : "Yuka's blue bra.", "ItemGroups" : "Equipable", "CleavageType" : "Compressed", "RenderLayer" : 2, "ClothingType" : "Bra", "AllowPanty" : true, "AllowBra" : false, "AllowBot" : true, "AllowTop" : true},
		"underwear_v1_panty_blue" : {"ItemType" : "Clothing", "ItemName" : "underwear_v1_panty_blue", "DisplayName" : "Yuka's Panty", "ItemThumb" : "res://Icons/180x180/underwear_v1_panty_blue.png", "ItemDescription" : "Yuka's blue panty.", "ItemGroups" : "Equipable", "CleavageType" : "Compressed", "RenderLayer" : 2, "ClothingType" : "Panty", "AllowPanty" : false, "AllowBra" : true, "AllowBot" : true, "AllowTop" : true},
		"black_pantyhose_1" : {"ItemType" : "Clothing", "ItemName" : "black_pantyhose_1", "DisplayName" : "Black Pantyhose", "ItemThumb" : "res://Sprites/Characters/Player/Outfits/black_pantyhose_1.png", "ItemDescription" : "A black pantyhose, it makes toes really sexy.", "ItemGroups" : "Equipable", "CleavageType" : "Ignore", "RenderLayer" : 2, "ClothingType" : "Accessory2", "AllowPanty" : true, "AllowBra" : true, "AllowBot" : true, "AllowTop" : true},
		"school_uniform_bare_legs" : {"ItemType" : "Clothing", "ItemName" : "school_uniform_bare_legs", "DisplayName" : "School Uniform", "ItemThumb" : "res://Sprites/Characters/Player/Outfits/school_uniform_bare_legs.png", "ItemDescription" : "Classic school uniform, makes any girl attractive (except the fat ones)", "ItemGroups" : "Equipable", "CleavageType" : "Ignore", "RenderLayer" : 3, "ClothingType" : "OnePiece", "AllowPanty" : true, "AllowBra" : true, "AllowBot" : false, "AllowTop" : false},
		"buruma_black" : {"ItemType" : "Clothing", "ItemName" : "buruma_black", "DisplayName" : "Black Buruma", "ItemThumb" : "res://Icons/180x180/buruma_black.png", "ItemDescription" : "Why were they banned??? #BringBurumaBack", "ItemGroups" : "Equipable", "CleavageType" : "Ignore", "RenderLayer" : 3, "ClothingType" : "Bot", "AllowPanty" : true, "AllowBra" : true, "AllowBot" : false, "AllowTop" : true},
		"tank_top_white" : {"ItemType" : "Clothing", "ItemName" : "tank_top_white", "DisplayName" : "Tank Top (White)", "ItemThumb" : "res://Icons/180x180/tank_top_white.png", "ItemDescription" : "The bigger the boobs the better it looks.", "ItemGroups" : "Equipable", "CleavageType" : "Compressed", "RenderLayer" : 3, "ClothingType" : "Top", "AllowPanty" : true, "AllowBra" : true, "AllowBot" : true, "AllowTop" : false},
		"tank_top_black" : {"ItemType" : "Clothing", "ItemName" : "tank_top_black", "DisplayName" : "Tank Top (Black)", "ItemThumb" : "res://Icons/180x180/tank_top_black.png", "ItemDescription" : "The bigger the boobs the better it looks.", "ItemGroups" : "Equipable", "CleavageType" : "Compressed", "RenderLayer" : 3, "ClothingType" : "Top", "AllowPanty" : true, "AllowBra" : true, "AllowBot" : true, "AllowTop" : false},
		
		#

	}
	
	if item == "random":
		return items[items.keys().pick_random()]
	
	return items[item]
	
func update_expression(charSprite):
	if panel_scenario_is_playing:
		return
	
	var clo = Save["Clothes"]
	if clo["OnePiece"] != null && clo["Panty"] != null:
		charSprite.clearBlush()
		charSprite.changeExpression("neutral")
		return
	if clo["Top"] != null && clo["Bot"] != null && (clo["Panty"] != null || clo["OnePieceUnderwear"] != null):
		charSprite.clearBlush()
		charSprite.changeExpression("neutral")
		return
	if clo["Panty"] == null && clo["OnePieceUnderwear"] == null:
		charSprite.changeBlush(1,1)
	if clo["Panty"] == null && clo["Bra"] == null && clo["OnePieceUnderwear"] == null:
		charSprite.changeBlush(2,1)
		charSprite.changeExpression("shy")
	if clo["Top"] == null:
		charSprite.changeBlush(1,1)
		charSprite.changeExpression("embarrassed")
	if clo["Bot"] == null:
		charSprite.changeBlush(2,2)
		charSprite.changeExpression("embarrassed")
	if clo["Bra"] == null && clo["Top"] == null && clo["OnePieceUnderwear"] == null:
		charSprite.changeBlush(1,2)
		charSprite.changeBlush(3,4)
		charSprite.changeExpression("super_embarrassed")
	if clo["Panty"] == null && clo["Bot"] == null && clo["OnePieceUnderwear"] == null:
		charSprite.changeBlush(2,2)
		charSprite.changeBlush(3,4)
		charSprite.changeExpression("super_embarrassed")
	
func get_ellapsed_time_in_ms():
	return Time.get_ticks_msec()
	
	
	
	
	
	
	
	

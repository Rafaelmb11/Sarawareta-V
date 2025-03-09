extends Control

signal outfit_mismatch(message : String)

@export var centralize : bool = false
@onready var glob = get_node("/root/globals")
@onready var isPubicHairVisible = true
@onready var darkerPreset = Color(0.5,0.5,0.5,1)
@onready var resourcesPath = "res://Sprites/Characters/"
@onready var pre_rendered_mode = false
@onready var expression = {
	"neutral": load(resourcesPath + "Player/Expressions/neutral.png"),
	"shy": load(resourcesPath + "Player/Expressions/shy.png"),
	"shy2": load(resourcesPath + "Player/Expressions/shy2.png"),
	"thinking": load(resourcesPath + "Player/Expressions/thinking.png"),
	"insecure": load(resourcesPath + "Player/Expressions/insecure.png"),
	"frown": load(resourcesPath + "Player/Expressions/frown.png"),
	"embarrassed": load(resourcesPath + "Player/Expressions/embarrassed.png"),
	"embarrassed2": load(resourcesPath + "Player/Expressions/embarrassed2.png"),
	"d_smile": load(resourcesPath + "Player/Expressions/d_smile.png"),
	"annoyed": load(resourcesPath + "Player/Expressions/annoyed.png"),
	"annoyed2": load(resourcesPath + "Player/Expressions/annoyed2.png"),
	"super_annoyed": load(resourcesPath + "Player/Expressions/super_annoyed.png"),
	"super_annoyed2": load(resourcesPath + "Player/Expressions/super_annoyed2.png"),
	"angry": load(resourcesPath + "Player/Expressions/angry.png"),
	"angry2": load(resourcesPath + "Player/Expressions/angry2.png"),
	"apologetic": load(resourcesPath + "Player/Expressions/apologetic.png"),
	"arrogant2": load(resourcesPath + "Player/Expressions/arrogant2.png"),
	"arrogant": load(resourcesPath + "Player/Expressions/arrogant.png"),
	"confident": load(resourcesPath + "Player/Expressions/confident.png"),
	"d_smug2": load(resourcesPath + "Player/Expressions/d_smug2.png"),
	"d_smug": load(resourcesPath + "Player/Expressions/d_smug.png"),
	"fired_up": load(resourcesPath + "Player/Expressions/fired_up.png"),
	"frantic": load(resourcesPath + "Player/Expressions/frantic.png"),
	"fretting": load(resourcesPath + "Player/Expressions/fretting.png"),
	"repulse": load(resourcesPath + "Player/Expressions/repulse.png"),
	"smug": load(resourcesPath + "Player/Expressions/smug.png"),
	"smug2": load(resourcesPath + "Player/Expressions/smug2.png"),
	"smug3": load(resourcesPath + "Player/Expressions/smug3.png"),
	"surprised": load(resourcesPath + "Player/Expressions/surprised.png"),
	"sympathetic": load(resourcesPath + "Player/Expressions/sympathetic.png"),
	"sympathetic2": load(resourcesPath + "Player/Expressions/sympathetic2.png"),
	"troubled": load(resourcesPath + "Player/Expressions/troubled.png"),
	"super_embarrassed": load(resourcesPath + "Player/Expressions/super_embarrassed.png"),
	"pout": load(resourcesPath + "Player/Expressions/pout.png"),
}

@onready var blush = {
	1: load(resourcesPath + "Player/Expressions/blush1.png"),
	2: load(resourcesPath + "Player/Expressions/blush2.png"),
	3: load(resourcesPath + "Player/Expressions/blush3.png"),
	4: load(resourcesPath + "Player/Expressions/blush4.png"),
}

@onready var body = {
	"body_base": load(resourcesPath + "Player/BodyParts/body_base.png"),
	"body_compressed_booba": load(resourcesPath + "Player/BodyParts/body_compressed_booba.png"),
	"body_hair": load(resourcesPath + "Player/BodyParts/body_hair.png"),
}

# Called when the node enters the scene tree for the first time.
func _ready():
	centralizer(centralize)
	
	

func _process(_delta):
	updateOutfit()
	
func centralizer(b : bool = false):
	if !b:
		return
	var all_nodes = self.get_children()
	for n in all_nodes:
			n.centered = true
			n.offset = Vector2(0, 1460)
	
func self_modulate(color : Color):
	$Body.self_modulate = color
	
func charMove(newPos : Vector2, speed : float):
	var tween = get_tree().create_tween()
	tween.tween_property(self, "position", newPos, speed)
	
func charScale(newScale : Vector2):
	self.scale = newScale

	
func changeExpression(key : String, transitionSpeed : float = .01):
	$Expression.texture = expression[key]
	$Expression.self_modulate = Color(.8,.8,.8,.2)
	var tween = get_tree().create_tween()
	tween.tween_property($Expression, "self_modulate", Color(1,1,1,1), transitionSpeed)
	
func changeBlush(slot : int, level : int):
	if level < 0 || level > 4:
		print("Invalid value provided in changeBlush")
		return null
	
	var target
	if slot == 1:
		target = $Blush
	else: if slot == 2:
		target = $Blush2
	else: if slot == 3:
		target = $Blush3
	else:
		target = $Blush
	
	if level == 0:
		target.texture = null
		return
	
	target.texture = blush[level]
	
func clearBlush():
	$Blush.texture = null
	$Blush2.texture = null
	$Blush3.texture = null
	
func togPubicHair(isVisible : bool):
	isPubicHairVisible = isVisible

func togFaceGloom(isVisible : bool):
	$Face_gloom.visible = isVisible

func moveTo(where : String):
	if where == "middle":
		self.position.x = 1920/2 - 444
	if where == "left":
		self.position.x = 1920/3 - 444
	if where == "right":
		self.position.x = 1920/1.5 - 444
	#self.position.y = self.position.y*self.scale.y

func playAnimation(which : String):
	if which == "waking":
		self.position.y = 1080
		self.modulate.a = 0
		var tween2 = get_tree().create_tween()
		tween2.tween_property(self, "modulate", Color(self.modulate.r,self.modulate.g,self.modulate.b,1), 2)
		var tween = get_tree().create_tween()
		tween.tween_property(self, "position", Vector2(self.position.x-5, self.position.y-270), 0.75)
		await tween.finished
		tween = get_tree().create_tween()
		tween.tween_property(self, "position", Vector2(self.position.x+5, self.position.y-270), 0.7)
		await tween.finished
		tween = get_tree().create_tween()
		tween.tween_property(self, "position", Vector2(self.position.x-5, self.position.y-270), 0.65)
		await tween.finished
		tween = get_tree().create_tween()
		tween.tween_property(self, "position", Vector2(self.position.x+5, self.position.y-270), 0.60)
		await tween.finished

func updateOutfit():
	if pre_rendered_mode:
		return
	
	var clo = glob.Save["Clothes"]
	if clo["Accessory"] != null:
		$Accessory.texture = load("res://Sprites/Characters/Player/Outfits/"+clo["Accessory"]+".png")
	else:
		$Accessory.texture = null
	if clo["Accessory2"] != null:
		$Accessory2.texture = load("res://Sprites/Characters/Player/Outfits/"+clo["Accessory2"]+".png")
	else:
		$Accessory2.texture = null
	if clo["Accessory3"] != null:
		$Accessory3.texture = load("res://Sprites/Characters/Player/Outfits/"+clo["Accessory3"]+".png")
	else:
		$Accessory3.texture = null
	if clo["OnePieceUnderwear"] != null:
		$OnePieceUnderwear.texture = load("res://Sprites/Characters/Player/Outfits/"+clo["OnePieceUnderwear"]+".png")
	else:
		$OnePieceUnderwear.texture = null
	if clo["Bra"] != null:
		$Bra.texture = load("res://Sprites/Characters/Player/Outfits/"+clo["Bra"]+".png")
	else:
		$Bra.texture = null
	if clo["Panty"] != null:
		$Panty.texture = load("res://Sprites/Characters/Player/Outfits/"+clo["Panty"]+".png")
	else:
		$Panty.texture = null
	if clo["OnePiece"] != null:
		$OnePiece.texture = load("res://Sprites/Characters/Player/Outfits/"+clo["OnePiece"]+".png")
	else:
		$OnePiece.texture = null
	if clo["Top"] != null:
		$Top.texture = load("res://Sprites/Characters/Player/Outfits/"+clo["Top"]+".png")
	else:
		$Top.texture = null
	if clo["Bot"] != null:
		$Bot.texture = load("res://Sprites/Characters/Player/Outfits/"+clo["Bot"]+".png")
	else:
		$Bot.texture = null
	$Booba.visible = false
	if glob.Save["Clothes"]["Bra"] != null:
		if glob.get_item(glob.Save["Clothes"]["Bra"])["CleavageType"] == "Compressed":
			$Booba.visible = true
	if glob.Save["Clothes"]["Top"] != null:
		if glob.get_item(glob.Save["Clothes"]["Top"])["CleavageType"] == "Compressed":
			$Booba.visible = true
	if glob.Save["Clothes"]["OnePieceUnderwear"] != null:
		if glob.get_item(glob.Save["Clothes"]["OnePieceUnderwear"])["CleavageType"] == "Compressed":
			$Booba.visible = true
	if glob.Save["Clothes"]["OnePiece"] != null:
		if glob.get_item(glob.Save["Clothes"]["OnePiece"])["CleavageType"] == "Compressed":
			$Booba.visible = true
	
func setEquipment(itemName : String):
	var itemData = glob.get_item(itemName)
	var type = itemData["ClothingType"]
	if type == "OnePieceUnderwear":
		if glob.Save["Clothes"]["Top"] != null || glob.Save["Clothes"]["Bot"] != null:
			if !itemData["AllowBot"] && !itemData["AllowTop"]:
				outfit_mismatch.emit("It seems this was intended to be used without any other clothing...")
				return
			if !itemData["AllowBot"] && itemData["AllowTop"]:
				outfit_mismatch.emit("It seems this was intended to be used without any bottoms...")
				return
			if itemData["AllowBot"] && !itemData["AllowTop"]:
				outfit_mismatch.emit("It seems this was intended to be used without a top...")
				return
		if glob.Save["Clothes"]["Bot"] != null:
			if !glob.get_item(glob.Save["Clothes"]["Bot"])["AllowPanty"]:
					outfit_mismatch.emit("I can't use this with these bottoms...")
					return
		if glob.Save["Clothes"]["Top"] != null:
			if !glob.get_item(glob.Save["Clothes"]["Top"])["AllowBra"]:
				outfit_mismatch.emit("I can't use it with this top...")
				return
			if glob.get_item(glob.Save["Clothes"]["Top"])["CleavageType"] != itemData["CleavageType"]:
				outfit_mismatch.emit("This doesn't match my top, I need to take it off first...")
				return
		if glob.Save["Clothes"]["OnePiece"] != null:
			if !glob.get_item(glob.Save["Clothes"]["OnePiece"])["AllowBra"]:
				outfit_mismatch.emit("I can't use it with this outfit...")
				return
			if glob.get_item(glob.Save["Clothes"]["OnePiece"])["CleavageType"] != itemData["CleavageType"]:
				outfit_mismatch.emit("This doesn't match my outfit...")
				return
				
		glob.Save["Clothes"]["Bra"] = null
		glob.Save["Clothes"]["Panty"] = null
		glob.Save["Clothes"]["OnePieceUnderwear"] = itemData["ItemName"]
		updateOutfit()
		return
		
	else: if type == "Bra":
		if glob.Save["Clothes"]["Top"] != null:
			if !glob.get_item(glob.Save["Clothes"]["Top"])["AllowBra"]:
				outfit_mismatch.emit("This top was meant to be used with bare breasts...")
				return
			if !itemData["AllowTop"]:
				outfit_mismatch.emit("It seems this shouldn't be used with a top on...")
				return
			if glob.get_item(glob.Save["Clothes"]["Top"])["CleavageType"] != itemData["CleavageType"]:
				outfit_mismatch.emit("This is a bad match with my top...")
				return
		if glob.Save["Clothes"]["OnePiece"] != null:
			if !glob.get_item(glob.Save["Clothes"]["OnePiece"])["AllowBra"]:
				outfit_mismatch.emit("This outfit was meant to be used with bare breasts...")
				return
			if !itemData["AllowTop"]:
				outfit_mismatch.emit("It seems this shouldn't be used with a top on...")
				return
			if glob.get_item(glob.Save["Clothes"]["OnePiece"])["CleavageType"] != itemData["CleavageType"]:
				outfit_mismatch.emit("This is a bad match with this outfit...")
				return
		glob.Save["Clothes"]["OnePieceUnderwear"] = null
		glob.Save["Clothes"]["Bra"] = itemData["ItemName"]
		updateOutfit()
		return
		
	else: if type == "Panty":
		if glob.Save["Clothes"]["Bot"] != null:
			if !glob.get_item(glob.Save["Clothes"]["Bot"])["AllowPanty"]:
				outfit_mismatch.emit("It seems that this outfit is meant to be used with no panties on...")
				return
			if !itemData["AllowBot"]:
				outfit_mismatch.emit("It seems this shouldn't be used with bottoms on...")
				return
		if glob.Save["Clothes"]["OnePiece"] != null:
			if !glob.get_item(glob.Save["Clothes"]["OnePiece"])["AllowPanty"]:
				outfit_mismatch.emit("It seems that this outfit is meant to be used with no panties on...")
				return
			if !itemData["AllowBot"]:
				outfit_mismatch.emit("It seems this shouldn't be used with bottoms on...")
				return
		glob.Save["Clothes"]["OnePieceUnderwear"] = null
		glob.Save["Clothes"]["Panty"] = itemData["ItemName"]
		updateOutfit()
		return
	
	else: if type == "OnePiece":
		if glob.Save["Clothes"]["Top"] != null || glob.Save["Clothes"]["Bot"] != null:
			if !itemData["AllowBra"] && !itemData["AllowPanty"]:
				outfit_mismatch.emit("It seems this was intended to be used without any underwear...")
				return
			if !itemData["AllowPanty"] && itemData["AllowBra"]:
				outfit_mismatch.emit("It seems this was made to be used with no panties on...")
				return
			if itemData["AllowBottom"] && !itemData["AllowBra"]:
				outfit_mismatch.emit("It seems this is intended to be used without a bra...")
				return
		if glob.Save["Clothes"]["Panty"] != null:
			if !glob.get_item(glob.Save["Clothes"]["Panty"])["AllowBot"]:
					outfit_mismatch.emit("I can't use this with these panties...")
					return
		if glob.Save["Clothes"]["Bra"] != null:
			if !glob.get_item(glob.Save["Clothes"]["Top"])["AllowTop"]:
				outfit_mismatch.emit("I can't use it with this bra...")
				return
			if glob.get_item(glob.Save["Clothes"]["Bra"])["CleavageType"] != itemData["CleavageType"]:
				outfit_mismatch.emit("This is a bad match with my bra...")
				return
		if glob.Save["Clothes"]["OnePieceUnderwear"] != null:
			if !glob.get_item(glob.Save["Clothes"]["OnePieceUnderwear"])["AllowTop"] || !glob.get_item(glob.Save["Clothes"]["OnePieceUnderwear"])["AllowBot"]:
				outfit_mismatch.emit("I can't use it with this underwear...")
				return
			if glob.get_item(glob.Save["Clothes"]["OnePieceUnderwear"])["CleavageType"] != itemData["CleavageType"]:
				outfit_mismatch.emit("This doesn't match my underwear...")
				return
				
		glob.Save["Clothes"]["Top"] = null
		glob.Save["Clothes"]["Bot"] = null
		glob.Save["Clothes"]["OnePiece"] = itemData["ItemName"]
		updateOutfit()
		return
	
	else: if type == "Top":
		if glob.Save["Clothes"]["Bra"] != null:
			if !glob.get_item(glob.Save["Clothes"]["Bra"])["AllowTop"]:
				outfit_mismatch.emit("The underwear I'm wearing is meant to be used without a top on...")
				return
			if !itemData["AllowBra"]:
				outfit_mismatch.emit("It seems this is meant to be used with bare breasts...")
				return
			if glob.get_item(glob.Save["Clothes"]["Bra"])["CleavageType"] != itemData["CleavageType"]:
				outfit_mismatch.emit("This is a bad match with my bra...")
				return
		if glob.Save["Clothes"]["OnePieceUnderwear"] != null:
			if !glob.get_item(glob.Save["Clothes"]["OnePieceUnderwear"])["AllowTop"]:
				outfit_mismatch.emit("I can't put this on with what I'm currently wearing...")
				return
			if !itemData["AllowBra"]:
				outfit_mismatch.emit("I can't put this on with what I'm currently wearing...")
				return
			if glob.get_item(glob.Save["Clothes"]["OnePiece"])["CleavageType"] != itemData["CleavageType"]:
				outfit_mismatch.emit("I can't put this on with what I'm currently wearing...")
				return
		glob.Save["Clothes"]["OnePiece"] = null
		glob.Save["Clothes"]["Top"] = itemData["ItemName"]
		updateOutfit()
		return
	
	else: if type == "Bot":
		if glob.Save["Clothes"]["Panty"] != null:
			if !glob.get_item(glob.Save["Clothes"]["Panty"])["AllowBot"]:
				outfit_mismatch.emit("This doesn't match my panties...")
				return
			if !itemData["AllowPanty"]:
				outfit_mismatch.emit("It seems this is meant to be used without any panties on...")
				return
			
		if glob.Save["Clothes"]["OnePieceUnderwear"] != null:
			if !glob.get_item(glob.Save["Clothes"]["OnePieceUnderwear"])["AllowBot"]:
				outfit_mismatch.emit("I can't put this on with what I'm currently wearing...")
				return
			if !itemData["AllowPanty"]:
				outfit_mismatch.emit("I can't put this on with what I'm currently wearing...")
				return
		glob.Save["Clothes"]["OnePiece"] = null
		glob.Save["Clothes"]["Bot"] = itemData["ItemName"]
		updateOutfit()
		return
	
	else: if type == "Accessory":
		glob.Save["Clothes"]["Accessory"] = itemData["ItemName"]
		updateOutfit()
		return
		
	else: if type == "Accessory2":
		glob.Save["Clothes"]["Accessory2"] = itemData["ItemName"]
		updateOutfit()
		return
		
	else: if type == "Accessory3":
		glob.Save["Clothes"]["Accessory3"] = itemData["ItemName"]
		updateOutfit()
		return
	
func unsetEquipment(itemName : String):
	var itemData = glob.get_item(itemName)
	var type = itemData["ClothingType"]
	if type == "OnePieceUnderwear":
		glob.Save["Clothes"]["OnePieceUnderwear"] = null
		updateOutfit()
		return
		
	else: if type == "Bra":
		glob.Save["Clothes"]["Bra"] = null
		updateOutfit()
		return
		
	else: if type == "Panty":
		glob.Save["Clothes"]["Panty"] = null
		updateOutfit()
		return
	
	else: if type == "OnePiece":
		glob.Save["Clothes"]["OnePiece"] = null
		updateOutfit()
		return
	
	else: if type == "Top":
		glob.Save["Clothes"]["Top"] = null
		updateOutfit()
		return
	
	else: if type == "Bot":
		glob.Save["Clothes"]["Bot"] = null
		updateOutfit()
		return
	
	else: if type == "Accessory":
		glob.Save["Clothes"]["Accessory"] = null
		updateOutfit()
		return
		
	else: if type == "Accessory2":
		glob.Save["Clothes"]["Accessory2"] = null
		updateOutfit()
		return
		
	else: if type == "Accessory3":
		glob.Save["Clothes"]["Accessory3"] = null
		updateOutfit()
		return
	
func preRenderedMode(b : bool):
	if b:
		pre_rendered_mode = true
		var children = self.get_children()
		for n in children:
			if n.name != "PreRendered" && n.name != "Blush" && n.name != "Blush2" && n.name != "Blush3" && n.name != "Expression" && n.name != "Face_gloom":
				n.visible = false
		$PreRendered.visible = true
	else:
		pre_rendered_mode = false
		var children = self.get_children()
		for n in children:
			if n.name == "PreRendered":
				n.visible = false
			else:
				n.visible = true

func _on_equip_set_equipment(itemName: String) -> void:
	setEquipment(itemName)

func _on_unequip_unset_equipment(itemName: String) -> void:
	unsetEquipment(itemName)

extends Control

@onready var glob = get_node("/root/globals")
@onready var GlobalPosition : Vector2 = self.global_position
var ItemData
var ItemType = ""
var isEmpty = true
var ItemName : String
var ItemDisplayName : String
var ItemDescription : String
var ItemThumb : Texture2D = null
var ItemGroups : Array
@onready var NodeName = self.name
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#load from save
	if NodeName in glob.Save:
		set_item(glob.Save[NodeName])


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !isEmpty && $TextureButton.button_pressed && glob.game_state == "inventory":
		$ItemInfoBox.visible = true
		$ItemInfoBox._set_global_position(Vector2(60,160))

	else:
		$ItemInfoBox.visible = false

func update_items():
	if NodeName in glob.Save:
		set_item(glob.Save[NodeName])
	else:
		clear_item()

func set_item(item : String):
	ItemData = glob.get_item(item)
	ItemType = ItemData["ItemType"]
	isEmpty = false
	ItemName = ItemData["ItemName"]
	ItemDisplayName = ItemData["DisplayName"]
	ItemDescription = ItemData["ItemDescription"]
	ItemThumb = load(ItemData["ItemThumb"])
	ItemGroups = ItemData["ItemGroups"].split(", ")
	if ItemThumb == null:
		ItemThumb = load("res://Icons/180x180/placeholder.png")
	$ItemThumb.texture = ItemThumb
	$ItemInfoBox/VBoxContainer/ThumbFrame/ThumbItem.texture = ItemThumb
	$ItemInfoBox/VBoxContainer/ItemName.text = ItemDisplayName
	$ItemInfoBox/VBoxContainer/Description.text = ItemDescription
	
	if self.get_parent().get_parent().name != "Storage":	
		if "Usable" in ItemGroups:
			$ItemInfoBox/VBoxContainer/Use.visible = true
		else: 
			$ItemInfoBox/VBoxContainer/Use.visible = false
		
		if "Eatable" in ItemGroups:
			$ItemInfoBox/VBoxContainer/Eat.visible = true
		else: 
			$ItemInfoBox/VBoxContainer/Eat.visible = false
		
		if "Equipable" in ItemGroups:
			var isEquiped = false
		
			var keys = glob.Save["Clothes"]
			for value in keys:
				if keys[value] == null:
					continue
				if keys[value] == ItemName:
					isEquiped = true
				
			if isEquiped:
				$ItemInfoBox/VBoxContainer/Equip.visible = false
				$ItemInfoBox/VBoxContainer/Unequip.visible = true
				$ItemThumb/EquipMark.visible = true
			else:
				$ItemThumb/EquipMark.visible = false
				$ItemInfoBox/VBoxContainer/Equip.visible = true
				$ItemInfoBox/VBoxContainer/Unequip.visible = false
		
		else: 
			$ItemThumb/EquipMark.visible = false
			$ItemInfoBox/VBoxContainer/Equip.visible = false
			$ItemInfoBox/VBoxContainer/Unequip.visible = false
	
		if "Discardable" in ItemGroups:
			$ItemInfoBox/VBoxContainer/Discard.visible = true
		else: 
			$ItemInfoBox/VBoxContainer/Discard.visible = false
	
	add_to_save()
	
func clear_item():
	ItemData = ""
	isEmpty = true
	ItemName = ""
	ItemDescription = ""
	ItemThumb = null
	$ItemThumb.texture = null
	$ItemInfoBox/VBoxContainer/ThumbFrame/ThumbItem.texture = null
	$ItemInfoBox/VBoxContainer/ItemName.text = ""
	$ItemInfoBox/VBoxContainer/Description.text = ""
	if self.name in glob.Save:
		glob.Save.erase(self.name)
	
	
	
func add_to_save():
	glob.Save[NodeName] = ItemName
	#print("Saved slot= "+NodeName+" : "+ItemName)


func _on_equip_pressed() -> void:
	var isEquiped = false
		
	var keys = glob.Save["Clothes"]
	for value in keys:
		if keys[value] == null:
			continue
		if keys[value] == ItemName:
			isEquiped = true
		
	if isEquiped:
		$ItemInfoBox/VBoxContainer/Equip.visible = false
		$ItemInfoBox/VBoxContainer/Unequip.visible = true
		$ItemThumb/EquipMark.visible = true
	else:
		$ItemThumb/EquipMark.visible = false
		$ItemInfoBox/VBoxContainer/Equip.visible = true
		$ItemInfoBox/VBoxContainer/Unequip.visible = false
		
	var clo = glob.Save["Clothes"]
	if clo["OnePiece"] != null:
		$"../../CharSprite".clearBlush()
		return
	if clo["Top"] != null && clo["Bot"] != null:
		$"../../CharSprite".clearBlush()
		$"../../CharSprite".changeExpression("neutral")
		return
	if clo["Top"] == null:
		$"../../CharSprite".changeBlush(1,1)
		$"../../CharSprite".changeExpression("embarrassed")
	if clo["Bot"] == null:
		$"../../CharSprite".changeBlush(2,1)
		$"../../CharSprite".changeExpression("embarrassed")
	if clo["Bra"] == null && clo["Top"] == null:
		$"../../CharSprite".changeBlush(1,2)
		$"../../CharSprite".changeBlush(3,4)
	if clo["Panty"] == null && clo["Bot"] == null:
		$"../../CharSprite".changeBlush(2,2)
		$"../../CharSprite".changeBlush(3,4)

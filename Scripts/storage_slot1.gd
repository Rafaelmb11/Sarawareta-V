extends Control

@onready var glob = get_node("/root/globals")
@onready var GlobalPosition : Vector2 = self.global_position
var ItemData
var isEmpty = true
var ItemName : String
var ItemDescription : String
var ItemThumb : Texture2D
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

func set_item(item : String):
	ItemData = glob.get_item(item)
	print(item)
	isEmpty = false
	ItemName = ItemData["ItemName"]
	ItemDescription = ItemData["ItemDescription"]
	ItemThumb = load(ItemData["ItemThumb"])
	ItemGroups = ItemData["ItemGroups"].split(", ")
	$ItemThumb.texture = ItemThumb
	$ItemInfoBox/VBoxContainer/ThumbFrame/ThumbItem.texture = ItemThumb
	$ItemInfoBox/VBoxContainer/ItemName.text = ItemName
	$ItemInfoBox/VBoxContainer/Description.text = ItemDescription
	
	if "Usable" in ItemGroups:
		$ItemInfoBox/VBoxContainer/Use.visible = true
	else: 
		$ItemInfoBox/VBoxContainer/Use.visible = false
		
	if "Eatable" in ItemGroups:
		$ItemInfoBox/VBoxContainer/Eat.visible = true
	else: 
		$ItemInfoBox/VBoxContainer/Eat.visible = false
		
	if "Equipable" in ItemGroups:
		$ItemInfoBox/VBoxContainer/Equip.visible = true
	else: 
		$ItemInfoBox/VBoxContainer/Equip.visible = false
	
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
	
	
	
func add_to_save():
	glob.Save[NodeName] = ItemName
	#print("Saved slot= "+NodeName+" : "+ItemName)

extends MarginContainer

@export var Title : String
@export var ItemPreview : Texture2D
@export var Price : int
@export var Description : String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$ShopItem/ItemPreview.texture = ItemPreview
	$ShopItem/Title.text = Title
	$ShopItem/Description.text = Description
	$ShopItem/Price.text = "$"+str(Price)

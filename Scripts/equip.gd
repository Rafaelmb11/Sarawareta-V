extends TextureButton

signal set_equipment(itemName : String)
signal update_equipment

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _on_pressed() -> void:
	var itemName = self.get_parent().get_parent().get_parent().ItemName
	set_equipment.emit(itemName)
	update_equipment.emit()

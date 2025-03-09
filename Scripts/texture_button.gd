extends TextureButton

signal pressed_custom(parent : Node)


func _on_pressed() -> void:
	pressed_custom.emit(self.get_parent())

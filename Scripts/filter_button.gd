extends TextureButton

signal apply_filter(target : String)
# Called when the node enters the scene tree for the first time.

func send_apply_filter_signal():
	apply_filter.emit(self.name)

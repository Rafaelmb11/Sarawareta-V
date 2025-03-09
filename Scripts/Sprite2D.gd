extends Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	# Get the screen size
	var screen_size = Vector2(1920,1080)

	# Get the original size of the sprite
	var original_size = texture.get_size()

	# Calculate the scale factors for both X and Y axes
	var scale_x = screen_size.x / original_size.x
	var scale_y = screen_size.y / original_size.y

	# Choose the minimum scale factor to maintain aspect ratio
	var min_scale = min(scale_x, scale_y)

	# Set the scale of the sprite
	scale = Vector2(min_scale, min_scale)

extends CharacterBody3D

@export_subgroup("Properties")
@export var movement_speed = 5
@export var jump_strength = 8

@onready var glob = get_node("/root/globals")

var weapon_index := 0

var mouse_sensitivity = 700
var gamepad_sensitivity := 0.075

var mouse_captured := true
var previous_mouse := true

var movement_velocity: Vector3
var rotation_target: Vector3

var input_mouse: Vector2

var gravity := 0.0

var previously_floored := false

var jump_single := true
var jump_double := true

var crouched = false

var container_offset = Vector3(1.2, -1.1, -2.75)

var tween:Tween

var currentCameraHeight


@onready var camera = $Head/Camera
@onready var sound_footsteps = $SoundFootsteps

@export var crosshair:TextureRect
@onready var originalCameraHeight : float

# Functions

func _ready():
	originalCameraHeight = camera.position.y
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
	#print("Original position "+str(self.position))
	#if glob.was_loaded_from_save:
		#self.position = glob.parseString2Vector3(glob.Save["PlayerPosition"])
		#camera.rotation = glob.parseString2Vector3(glob.Save["PlayerCameraRotation"])
		#print("Saved position "+str(self.position))
		#glob.was_loaded_from_save = false
	

func _physics_process(delta):
	
	$Info.text = str(self.position)
	
	if Input.is_action_just_pressed("crouch"):
		crouched = !crouched
		handle_crouch()
	
	
	
	# Handle functions
	
	handle_controls(delta)
	handle_gravity(delta)
	
	# Movement

	var applied_velocity: Vector3
	
	movement_velocity = transform.basis * movement_velocity # Move forward
	
	applied_velocity = velocity.lerp(movement_velocity, delta * 10)
	applied_velocity.y = -gravity
	
	velocity = applied_velocity
	move_and_slide()
	
	# Rotation
	
	camera.rotation.z = lerp_angle(camera.rotation.z, -input_mouse.x * 25 * delta, delta * 5)	
	
	camera.rotation.x = lerp_angle(camera.rotation.x, rotation_target.x, delta * 25)
	rotation.y = lerp_angle(rotation.y, rotation_target.y, delta * 25)
	
	
	
	# Movement sound
	
	sound_footsteps.stream_paused = true
	
	
	if is_on_floor():
		if abs(velocity.x) > 0.8 or abs(velocity.z) > 0.8:
			sound_footsteps.stream_paused = false
	
	# Landing after jump or falling
	
	camera.position.y = lerp(camera.position.y, 0.0, delta * 5)
	
	if is_on_floor() and gravity > 1 and !previously_floored: # Landed
		camera.position.y = -0.1
	
	previously_floored = is_on_floor()
	
	# Falling/respawning
	
	if position.y < -10:
		self.position = Vector3(1,1.5,1.3)

# Mouse movement

func handle_crouch():
	var col = $Collider
	var crouchedPosition = col.scale
	var regularPosition = col.scale
	regularPosition.y = 1
	crouchedPosition.y = .25
	if col.scale.y == 1 && crouched:
		movement_speed = 3
		var tween = get_tree().create_tween()
		tween.tween_property(col, "scale", crouchedPosition, .2)
		await tween.finished
		return
	if  col.scale.y != 1 && !crouched:
		movement_speed = 5
		var tween = get_tree().create_tween()
		tween.tween_property(col, "scale", regularPosition, .2)
		await tween.finished
		return

func _input(event):
	
	
	if event is InputEventMouseMotion and mouse_captured:
		
		input_mouse = event.relative / mouse_sensitivity
		
		rotation_target.y -= event.relative.x / mouse_sensitivity
		rotation_target.x -= event.relative.y / mouse_sensitivity

func handle_controls(_delta):
	
	
	# Mouse capture
	
	#if Input.is_action_just_pressed("mouse_capture"):
		#Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		#mouse_captured = true
	#
	#if Input.is_action_just_pressed("mouse_capture_exit"):
		#Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		#mouse_captured = false
		
		#input_mouse = Vector2.ZERO
	
	# Movement
	if !mouse_captured:
		return;
	var input := Input.get_vector("move_left", "move_right", "move_forward", "move_back")
	
	movement_velocity = Vector3(input.x, 0, input.y).normalized() * movement_speed
	
	# Rotation
	
	var rotation_input := Input.get_vector("camera_right", "camera_left", "camera_down", "camera_up")
	
	rotation_target -= Vector3(-rotation_input.y, -rotation_input.x, 0).limit_length(1.0) * gamepad_sensitivity
	rotation_target.x = clamp(rotation_target.x, deg_to_rad(-90), deg_to_rad(90))
	
	
	

# Handle gravity

func handle_gravity(delta):
	
	gravity += 20 * delta
	
	if gravity > 0 and is_on_floor():
		
		jump_single = true
		gravity = 0


func _on_textbox_block_player_input():
	self.process_mode = Node.PROCESS_MODE_DISABLED

	

#
#func _on_textbox_unblock_player_input():
	#self.process_mode = Node.PROCESS_MODE_INHERIT
#
#
#func _on_main_block_player_input():
	#self.process_mode = Node.PROCESS_MODE_DISABLED
#
#
#
#func _on_main_unblock_player_input():
	#self.process_mode = Node.PROCESS_MODE_INHERIT

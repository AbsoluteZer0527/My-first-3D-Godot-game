extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@onready var body = $Body
@onready var animation_tree = $AnimationTree

var playback
var direction: Vector2
var screen: Vector2
var dragging := false
var win_pos: Vector2
var mouse_pos: Vector2
var mouse_in_pos: Vector2

func _ready() -> void:
	playback = animation_tree.get("parameters/playback")
	screen = DisplayServer.screen_get_size()

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			dragging = true
			mouse_in_pos = get_viewport().get_mouse_position()

func _physics_process(delta: float) -> void:

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

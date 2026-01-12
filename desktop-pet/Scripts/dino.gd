extends CharacterBody2D


const SPEED = 100.0
const JUMP_VELOCITY = -400.0
const WIN_SIZE = Vector2(64,64)

@onready var body = $Body
@onready var animation_tree = $AnimationTree

var playback
var direction: Vector2
var screen: Vector2
var dragging := false
var win_pos: Vector2
var mouse_pos: Vector2
var mouse_in_pos: Vector2
var vel:Vector2

var round_time:float = 3.0
var time_count:float = 0

func _ready() -> void:
	playback = animation_tree.get("parameters/playback")
	screen = DisplayServer.screen_get_size()
	get_tree().get_root().size = WIN_SIZE
func _input(event):
	#record when the mouse is pressed down
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			dragging = true
			mouse_in_pos = get_viewport().get_mouse_position()
		else:
			dragging = false
			
	if event is InputEventMouseMotion and dragging:
		mouse_pos = get_viewport().get_mouse_position()
		get_tree().get_root().position = Vector2(get_tree().get_root().position) + mouse_pos - mouse_in_pos

	if event is InputEventKey and event.is_action_pressed("exit"):
		get_tree().quit()
		
var auto_direction:Vector2

func _physics_process(delta: float) -> void:
	vel = Vector2.ZERO
	direction = Vector2(Input.get_axis("ui_left", "ui_right"), Input.get_axis("ui_up", "ui_down"))
	if direction != Vector2.ZERO:
		vel = direction * delta * SPEED
		time_count = round_time
	else:
		time_count -= delta
		if time_count < 0:
			time_count = round_time
			auto_direction = select_new_direction()
		vel = auto_direction * SPEED * delta
	
	win_pos = Vector2(get_tree().get_root().position) + vel
	win_pos.x = clamp(win_pos.x, 0, screen.x)
	win_pos.y = clamp(win_pos.y, 0, screen.y)
	
	get_tree().get_root().position = win_pos

	pick_new_state() 
	
#random walking
var walk:float = false
func select_new_direction() -> Vector2:
	walk = !walk
	if walk:
		return Vector2(
			randi_range(-1,1),
			randi_range(-1,1)
		)
	else:
		return Vector2.ZERO
		
func pick_new_state():
	if dragging:
		playback.travel("fly")
	elif (vel != Vector2.ZERO):
		playback.travel("walk")
	else:
		playback.travel("idle")

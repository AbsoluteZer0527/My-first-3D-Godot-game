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
var vel:Vector2

func _ready() -> void:
	playback = animation_tree.get("parameters/playback")
	screen = DisplayServer.screen_get_size()

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
		
func _physics_process(delta: float) -> void:
	
	var direction := Vector2(Input.get_axis("ui_left", "ui_right"), Input.get_axis("ui_up", "ui_down"))
	if direction != Vector2.ZERO:
		vel = direction * delta * SPEED
		
	win_pos = Vector2(get_tree().get_root().position) + vel
	win_pos.x = clamp(win_pos.x, 0, screen.x)
	win_pos.y = clamp(win_pos.y, 0, screen.y)
	
	get_tree().get_root().position = win_pos

	pick_new_state() 
	
func pick_new_state():
	if dragging:
		playback.travel("fly")
	elif (vel != Vector2.ZERO):
		playback.travel("walk")
	else:
		playback.travel("idle")

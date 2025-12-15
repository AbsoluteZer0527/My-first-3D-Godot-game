extends Area3D

@export var rotation_speed: float = 0.5

@export var floating_speed: float = 0.01
@export var floating_magnitude: float = 0.05
var original_y: float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	original_y = position.y


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	rotation.y += rotation_speed* delta
	position.y = original_y + sin(Time.get_ticks_msec()*floating_speed) * floating_magnitude

extends Node3D
class_name GameManager

static var instance: GameManager

@export var collected_items: Dictionary[String, int] = {
		'DIAMOND': 0,
		'COIN': 0,
		'CHERRY': 0,
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if instance == null: 
		instance = self
	else:
		queue_free()
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func respawn_player(body: Node3D) -> void:
	if body is CharacterBody3D:
		get_tree().reload_current_scene()

func collect_item(item_type):
	collected_items[item_type] += 1

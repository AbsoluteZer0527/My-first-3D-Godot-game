extends Node3D
class_name GameManager

static var instance: GameManager

@export var collected_items: Dictionary[String, int] = {
		'DIAMOND': 0,
		'COIN': 0,
		'CHERRY': 0,
}

@export var item_labels: Dictionary[String, Label]

#keep track of the checkpoints thats activated.
var activated_checkpoints: Array[Checkpoint]

@export var win_label: Label
var is_game_over: bool = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if instance == null: 
		instance = self
	else:
		queue_free()
		
	win_label.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func respawn_player(body: Node3D) -> void:
	if body is CharacterBody3D:
		#if havent had any check point, respawn at the start
		if len(activated_checkpoints) == 0:
			Player.instance.position = Player.instance.spawn_position
		else:
			#we want to respawn at the last check point
			Player.instance.position = activated_checkpoints[-1].position + Vector3(-2,3,0)
func collect_item(item_type):
	collected_items[item_type] += 1
	item_labels[item_type].text = str(collected_items[item_type])
	
func win_game():
	win_label.visible = true
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	is_game_over = true

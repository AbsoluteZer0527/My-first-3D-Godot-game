extends Control
@export_group("UI")
@export var character_name_text : Label
@export var text_box : Label
@export var left_avatar: TextureRect
@export var right_avatar: TextureRect

@export_group("Dialogue")
@export var main_dialogue: DialogueGroup

var dialogue_index := 0 
func display_next_dialogue():
	var dialogue := main_dialogue.dialogue_list[dialogue_index]
	
	character_name_text.text = dialogue.character_name
	text_box.text = dialogue.content
	if dialogue.show_on_left:
		left_avatar.texture = dialogue.avatar
		right_avatar.texture = null
	else:
		left_avatar.texture = null
		right_avatar.texture = dialogue.avatar
		
	dialogue_index+=1
	
func _ready() -> void:
	display_next_dialogue()
		
func _on_click(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		display_next_dialogue()
		
		

extends Control

signal dancer_dropped(dancer_id: int, pos: Vector2)

@export var dancer_button_template: PackedScene
@export var dancer_select_panel: Control

var dancer_list

func _populate_dancer_panel() -> void:
	for dance in dancer_list:
		var dancer_button = dancer_button_template.duplicate()
		# populate dancer specific data into the dancer button
		# connect dancer button
		dancer_select_panel.add_child(dancer_button)
	pass


func _on_add_dancer_button_pressed() -> void:
	var dancer_button: DancerButton = dancer_button_template.instantiate()
	dancer_button.custom_minimum_size = Vector2(40,40)
	dancer_button.dancer_dropped.connect(_on_dancer_dropped)
	dancer_select_panel.add_child(dancer_button)

func _on_dancer_dropped(dancer_id: int, pos: Vector2):
	dancer_dropped.emit(dancer_id, pos)

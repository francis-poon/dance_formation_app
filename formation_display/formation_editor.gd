class_name FormationEditor
extends Control

var current_formation: DanceFormation

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for child in get_children():
		remove_child(child)

func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT \
	 and event.is_pressed() and current_formation:
		current_formation.add_dancer(event.global_position)

func set_formation(formation: DanceFormation):
	if current_formation:
		remove_child(current_formation)
	current_formation = formation
	current_formation.show()
	add_child(current_formation)

func clear_formation():
	if current_formation:
		remove_child(current_formation)
		current_formation = null

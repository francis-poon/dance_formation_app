class_name FormationDisplay
extends Control

@export var manager: FormationManager
@export var selector: FormationSelector
@export var editor: FormationEditor
@export var preview: Control

func _ready() -> void:
	for formation in manager.data.id_formation_dict.values():
		selector.add_formation(formation)

func _on_new_formation_request() -> void:
	var new_formation: DanceFormation = manager.get_new_formation()
	selector.add_formation(new_formation)
	editor.set_formation(new_formation)
	new_formation.formation_changed.connect(_on_formation_changed)


func _on_select_formation(id: int) -> void:
	display_formation(id)

func display_formation(id: int):
	if manager.has_formation(id):
		editor.set_formation(manager.get_formation(id))

func clear_display():
	editor.clear_formation()

func _on_formation_changed(dancer_positions: Array[Vector2]):
	for child in preview.get_children():
		preview.remove_child(child)
	preview.add_child(editor.current_formation.get_preview())

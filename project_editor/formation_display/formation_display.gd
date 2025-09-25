class_name FormationDisplay
extends Control

@export var _selector: FormationSelector
@export var _editor: FormationEditor

var _manager: FormationManager

func _ready() -> void:
	_manager = get_tree().get_first_node_in_group("formation_manager")
	_manager.new_data_loaded.connect(_on_manager_new_data_loaded)

func _on_manager_new_data_loaded():
	_selector.clear_formations()
	for formation in _manager.data.id_formation_dict.values():
		_selector.add_formation(formation)

func _on_new_formation_request() -> void:
	var new_formation: DanceFormation = _manager.get_new_formation()
	_selector.add_formation(new_formation)
	_editor.set_formation(new_formation)


func _on_select_formation(id: int) -> void:
	display_formation(id)

func display_formation(id: int):
	if _manager.has_formation(id):
		_editor.set_formation(_manager.get_formation(id))

func clear_display():
	_editor.clear_formation()

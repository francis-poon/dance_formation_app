class_name FormationSelector
extends ScrollContainer

signal select_formation(id: int)
signal new_formation_request

@export var formation_button_scene: PackedScene
@export var formation_container: Container


func add_formation(formation: DanceFormation):
	var formation_button: FormationButton = formation_button_scene.instantiate()
	formation_button.set_formation(formation)
	formation_button.select_formation.connect(_on_select_formation)
	formation_container.add_child(formation_button)

func _on_select_formation(id: int):
	select_formation.emit(id)

func _on_add_formation_button_pressed() -> void:
	new_formation_request.emit()

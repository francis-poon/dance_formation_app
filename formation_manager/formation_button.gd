class_name FormationButton
extends Button

signal select_formation(id: int)

@export var _preview_modulation: Color

var formation: DanceFormation

func set_formation(p_formation: DanceFormation):
	formation = p_formation

func _on_pressed() -> void:
	if formation:
		select_formation.emit(formation.data.id)
	else:
		select_formation.emit(-1)

func _get_drag_data(_at_position: Vector2) -> Variant:
	var drag_data = _get_preview()
	set_drag_preview(drag_data)
	#formation.duplicate()
	return _get_preview()

func _get_preview() -> Control:
	return formation.get_preview()

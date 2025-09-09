class_name FormationButton
extends Control

signal select_formation(id: int)

@export var _preview_holder: AspectRatioContainer
@export var _preview_modulation: Color

var formation: DanceFormation

func set_formation(p_formation: DanceFormation):
	formation = p_formation
	for child in _preview_holder.get_children():
		_preview_holder.remove_child(child)
	
	var preview: DanceFormationPreview = formation.get_preview()
	_preview_holder.ratio = preview.size.x / preview.size.y
	_preview_holder.add_child(preview)

func _on_pressed() -> void:
	if formation:
		select_formation.emit(formation.data.id)
	else:
		select_formation.emit(-1)

func _get_drag_data(_at_position: Vector2) -> Variant:
	var drag_data = _get_preview()
	drag_data.scale = Vector2(0.2, 0.2)
	set_drag_preview(drag_data)
	#formation.duplicate()
	return _get_preview()

func _get_preview() -> Control:
	return formation.get_preview()

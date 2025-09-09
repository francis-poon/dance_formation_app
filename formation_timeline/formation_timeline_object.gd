class_name FormationTimelineObject
extends Control

var formation_id: int
var formation_preview: DanceFormationPreview:
	set(value):
		if formation_preview:
			formation_preview.queue_free()
		formation_preview = value
		add_child(formation_preview)

func set_data(p_formation_id: int, p_formation_preview: DanceFormationPreview):
	size = p_formation_preview.target_size
	formation_id = p_formation_id
	formation_preview = p_formation_preview

func _get_drag_data(_at_position: Vector2) -> Variant:
	set_drag_preview(_get_preview())
	return self

func _get_preview() -> Control:
	return formation_preview

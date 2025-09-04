class_name DanceFormationPreview
extends Control

var preview: Control
var id: int

func set_preview(p_id: int, p_preview: Control):
	if preview:
		remove_child(preview)
	
	id = p_id
	preview = p_preview
	add_child(preview)

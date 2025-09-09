class_name FormationTimeline
extends Control

signal display_formation(id: int)

@export var timeline: Control

var current_formation_id: int = -1

func _on_h_scroll_bar_value_changed(value: float) -> void:
	_update_formation(value)

func _on_color_rect_2_data_updated() -> void:
	_update_formation(timeline.get_current_value())

func _update_formation(value):
	# check if formation has changed
	# IF formatin has changed, emit signal with new formation id 
	# else do nothing
	var target_idx = timeline.marker_cues.find_custom(func(a): return value < a[0])
	var new_id: int = -1
	match(target_idx):
		0:
			pass
		-1:
			new_id = timeline.marker_cues[-1][1]
		_:
			new_id = timeline.marker_cues[target_idx - 1][1]
	if current_formation_id != new_id:
		current_formation_id = new_id
		display_formation.emit(current_formation_id)

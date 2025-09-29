class_name TimelineData
extends Resource

@export var duration: float
@export var markers: Array

func _init(p_duration: float = 10, p_markers: Array = []) -> void:
	duration = p_duration
	markers = p_markers

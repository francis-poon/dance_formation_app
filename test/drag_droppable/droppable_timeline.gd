extends Control

signal data_updated

@export var holder: Node

var marker_cues: Array

func _ready():
	marker_cues = []

func _can_drop_data(_at_position: Vector2, data: Variant) -> bool:
	return data is TestDraggableB

func _drop_data(_at_position: Vector2, data: Variant) -> void:
	holder.add_child(data)
	data.position = Vector2(_at_position.x, size.y / 2 - data.size.y / 2)
	_update_data()

func _update_data():
	marker_cues = []
	for child in holder.get_children():
		marker_cues.append([child.position.x, child.data])
	marker_cues.sort_custom(func(a, b): return a[0] < b[0])
	data_updated.emit()

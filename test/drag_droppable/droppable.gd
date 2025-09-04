extends Control


func _can_drop_data(_at_position: Vector2, data: Variant) -> bool:
	return data is TestDraggableB

func _drop_data(_at_position: Vector2, data: Variant) -> void:
	var new_data = data
	#new_data.get_parent().remove_child(new_data)
	add_child(new_data)
	new_data.position = Vector2(_at_position.x, size.y / 2 - data.size.y / 2)

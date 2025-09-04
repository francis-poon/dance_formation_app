class_name TestDraggable
extends Control

@export var c_rect: ColorRect
@export var drop_data_asset: Control

func _get_drag_data(_at_position: Vector2) -> Variant:
	var drop_data = drop_data_asset.duplicate()
	drop_data.show()
	set_drag_preview(c_rect.duplicate())
	return drop_data

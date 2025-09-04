
extends Button

@export var drop_data_asset: Control

func _get_drag_data(_at_position: Vector2) -> Variant:
	var drop_data = drop_data_asset.duplicate()
	drop_data.show()
	set_drag_preview(_get_preview())
	return drop_data

func _get_preview() -> Control:
	var preview = drop_data_asset.duplicate()
	preview.show()
	return preview

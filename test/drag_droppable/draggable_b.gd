class_name TestDraggableB
extends TextureRect

@export var data: String

func _get_drag_data(_at_position: Vector2) -> Variant:
	set_drag_preview(_get_preview())
	return self

func _get_preview() -> Control:
	var preview: TextureRect = TextureRect.new()
	preview.texture = texture
	preview.size = size
	return preview

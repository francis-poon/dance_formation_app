class_name DanceFormationPreview
extends Control

@export var dancer_sprite: Sprite2D = Sprite2D.new()
@export var stage: ColorRect = ColorRect.new()

var id: int
var dancers: Array[Sprite2D]

func _ready():
	dancers = []

func set_preview(p_id: int, dancer_positions: Array[Vector2], preview_size: Vector2):
	size = preview_size
	id = p_id
	_update_dancers(dancer_positions)

func _update_dancers(dancer_positions: Array[Vector2]):
	if dancers.size() > dancer_positions.size():
		for i in range(dancer_positions.size(), dancers.size()):
			dancers[i].queue_free()
	if dancers.size() != dancer_positions.size():
		dancers.resize(dancer_positions.size())
	for i in range(dancer_positions.size()):
		if not dancers[i]:
			dancers[i] = dancer_sprite.duplicate()
			dancers[i].show()
			stage.add_child(dancers[i])
		dancers[i].position = dancer_positions[i]

func _on_formation_changed(dancer_positions: Array[Vector2]):
	_update_dancers(dancer_positions)

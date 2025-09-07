class_name DanceFormationPreview
extends Control

@export var dancer_sprite: Sprite2D
@export var stage: ColorRect
@export var stage_size: Vector2 = Vector2(660, 422):
	set(value):
		stage_size = value
		stage.size = value
@export var preview_scale: Vector2 = Vector2(0.2, 0.2):
	set(value):
		preview_scale = value
		_update_scale()

var id: int
var dancers: Array[Sprite2D]

func _ready():
	dancers = []
	stage.size = stage_size

func set_preview(p_id: int, dancer_positions: Array[Vector2]):
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
			stage.add_child(dancers[i])
		dancers[i].position = dancer_positions[i] * preview_scale

func _update_scale():
	pass

func _on_formation_changed(dancer_positions: Array[Vector2]):
	_update_dancers(dancer_positions)

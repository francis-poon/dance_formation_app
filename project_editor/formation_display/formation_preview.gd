class_name DanceFormationPreview
extends Control

@export var dancer_sprite: Sprite2D
@export var dancer_holder: Control

@export var id: int
@export var dancers: Array[Sprite2D]
@export var target_size: Vector2

#func _ready():
	#dancers = []

func set_preview(p_id: int, dancer_positions: Array[Vector2], preview_size: Vector2):
	size = preview_size
	target_size = preview_size
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
			dancer_holder.add_child(dancers[i])
		dancers[i].position = dancer_positions[i]

func _on_formation_changed(dancer_positions: Array[Vector2]):
	_update_dancers(dancer_positions)


func _on_resized() -> void:
	dancer_holder.scale = size / target_size

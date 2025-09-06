class_name DanceFormationPreview
extends Control

@export var dancer_sprite: Sprite2D
@export var stage: ColorRect

var id: int
var dancers: Array[Sprite2D]

func set_preview(p_id: int, dancer_positions: Array[Vector2]):
	id = p_id
	
	if dancers.size() < dancer_positions.size():
		var old_size: int = dancers.size()
		dancers.resize(dancer_positions.size())
	for i in range(dancer_positions.size()):
		if not dancers[i]:
			dancers[i] = dancer_sprite.duplicate()
			stage.add_child(dancers[i])
		dancers[i].position = dancer_positions[i]

func _on_formation_changed(dancer_positions: Array[Vector2]):
	pass

class_name DanceFormationData
extends Resource

@export var id: int
@export var dancer_positions: Array[Vector2]


func _init(p_id: int = -1, p_dancer_positions: Array[Vector2] = []):
	if p_id == -1:
		id = randi()
	else:
		id = p_id
	dancer_positions = p_dancer_positions

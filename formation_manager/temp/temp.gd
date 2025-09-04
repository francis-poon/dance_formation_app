extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var formations: DanceFormationCollection = DanceFormationCollection.new()
	for child in get_children():
		formations.id_formation_dict[child.data.id] = child
	ResourceSaver.save(formations.serialize(), "temp.tres")



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

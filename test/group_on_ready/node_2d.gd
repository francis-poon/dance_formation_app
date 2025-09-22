extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var pm = get_tree().get_first_node_in_group("project_manager")
	print(pm)
	print(pm.is_node_ready())
	await pm.ready
	print(pm.is_node_ready())

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

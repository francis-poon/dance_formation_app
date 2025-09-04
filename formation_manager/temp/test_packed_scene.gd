extends Node2D

@export var res_container: Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	res_container.res.val = 3
	var packed_scene: PackedScene = PackedScene.new()
	packed_scene.pack(res_container)
	var new_res_container = packed_scene.instantiate()
	print(new_res_container.res.val)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

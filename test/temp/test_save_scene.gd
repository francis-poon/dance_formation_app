extends Node2D

@export var scene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#var par_res: ParentRes0124 = ParentRes0124.new(scene)
	#ResourceSaver.save(par_res, "res://07-30_08-05 dance formation app/formation_manager/temp/test.tres")
	var par_res: ParentRes0124 = ResourceLoader.load("res://07-30_08-05 dance formation app/formation_manager/temp/test.tres")
	var save_scene = par_res.scene.instantiate()
	print(save_scene.res.val)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

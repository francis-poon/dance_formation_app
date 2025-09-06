extends Node2D

@export var res: Res0123

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	res = Res0123.new()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

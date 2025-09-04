extends Node2D

@export var sprite: Sprite2D
@export var label: Label

func _ready():
	pass

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		sprite.global_position = get_global_mouse_position()
		var exp =  get_global_transform_with_canvas().affine_inverse() * event.position
		label.text = str("Ev Pos: {0}
		Ev Glo Pos: {1}
		Glo MP: {2}
		Exp: {3}".format([event.position, event.global_position, get_global_mouse_position(), exp]))
		
	if event is InputEventMouseButton and event.is_pressed():
		var blep = sprite.duplicate()
		add_child(blep)
		blep.global_position = event.global_position
		

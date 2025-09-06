class_name Dancer
extends Area2D

signal dancer_moved(dancer_id: int, position: Vector2)
signal dancer_deleted(dancer_id: int)

@export var slider: HSlider
@export var sprite: Sprite2D

var id: int

var is_mouse_in: bool
var is_pressed: bool

func _ready():
	is_mouse_in = false

func _input(event: InputEvent) -> void:
	# TODO: Emit dancer_moved signal when dancer is dragged
	if event is InputEventMouseMotion and is_pressed:
		global_position = event.global_position
	if event is InputEventMouseButton and is_mouse_in:
		if event.button_index == MOUSE_BUTTON_LEFT:
			get_viewport().set_input_as_handled()
			is_pressed = event.is_pressed()
		elif event.button_index == MOUSE_BUTTON_RIGHT:
			get_viewport().set_input_as_handled()
			dancer_deleted.emit(id)
			queue_free()

func get_sprite() -> Sprite2D:
	return sprite.duplicate()

func _on_mouse_entered() -> void:
	is_mouse_in = true

func _on_mouse_exited() -> void:
	is_mouse_in = false

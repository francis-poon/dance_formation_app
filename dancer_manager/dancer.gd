class_name Dancer
extends Area2D

@export var slider: HSlider
@export var sprite: Sprite2D

var is_move: bool
var cur_move_time: float
var move_time: float = 2
var targets: Array
var is_mouse_in: bool
var is_pressed: bool

func _ready():
	is_mouse_in = false
	cur_move_time = 0
	is_move = false
	targets = []

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and is_pressed:
		global_position = event.global_position
	if event is InputEventMouseButton and is_mouse_in:
		if event.button_index == MOUSE_BUTTON_LEFT:
			get_viewport().set_input_as_handled()
			is_pressed = event.is_pressed()
		elif event.button_index == MOUSE_BUTTON_RIGHT:
			get_viewport().set_input_as_handled()
			queue_free()

func get_sprite() -> Sprite2D:
	return sprite.duplicate()

func _on_mouse_entered() -> void:
	is_mouse_in = true

func _on_mouse_exited() -> void:
	is_mouse_in = false

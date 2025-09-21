class_name DancerButton
extends Control

signal dancer_dropped(dancer_id: int, pos: Vector2)

@export var dancer_drop_marker: Sprite2D

var is_mouse_dragging: bool
var dancer_id: int = 0

func _ready() -> void:
	dancer_drop_marker.hide()
	is_mouse_dragging = false

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and is_mouse_dragging:
		dancer_drop_marker.position = event.position

func _on_button_button_down() -> void:
	is_mouse_dragging = true
	dancer_drop_marker.global_position = get_global_mouse_position()
	dancer_drop_marker.show()


func _on_button_button_up() -> void:
	is_mouse_dragging = false
	dancer_drop_marker.hide()
	dancer_dropped.emit(dancer_id, dancer_drop_marker.global_position)

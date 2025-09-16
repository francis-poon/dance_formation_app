class_name PlaybackCursor
extends Control

signal value_changed(value: float)

@export var _scroll_bar: HScrollBar
@export var _slider: HSlider

var is_dragging: bool = false

var max_value: float = 100:
	set(value):
		max_value = value
		_scroll_bar.max_value = max_value
		_slider.max_value = max_value
var value: float

func _ready():
	value = 0
	_scroll_bar.max_value = max_value
	_slider.max_value = max_value

func set_value(p_value: float):
	_slider.value = p_value

func _on_h_slider_value_changed(p_value: float) -> void:
	value = p_value
	_scroll_bar.value = p_value
	value_changed.emit(p_value)


func _on_h_slider_drag_ended(value_changed: bool) -> void:
	is_dragging = false


func _on_h_slider_drag_started() -> void:
	is_dragging = true

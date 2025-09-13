extends Control

signal value_changed(value: float)

@export var _scroll_bar: HScrollBar
@export var _slider: HSlider

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

func _on_h_slider_value_changed(p_value: float) -> void:
	value = p_value
	_scroll_bar.value = p_value
	value_changed.emit(p_value)

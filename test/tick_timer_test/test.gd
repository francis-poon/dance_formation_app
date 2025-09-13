extends Control

@export var wait_time: float = 10

@export var _slider: HSlider
@export var _label: Label
@export var _timer: TickBasedTimer

var _is_playing: bool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_is_playing = false
	_timer.wait_time = wait_time
	_slider.max_value = wait_time
	_label.text = str(_timer.current_time)


func _on_tick_based_timer_time_changed(time: float) -> void:
	_slider.value = time
	_label.text = str(time)


func _on_play_button_pressed() -> void:
	if _is_playing:
		_timer.stop()
	else:
		_timer.start()
	_is_playing = !_is_playing


func _on_reset_button_pressed() -> void:
	_timer.reset()

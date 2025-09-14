class_name FormationTimeline
extends Control

signal display_formation(id: int)

@export var timeline_tray: TimelineTray
@export var wait_time: float = 10

@export var _play_pause_button: Button
@export var _tick_timer: TickBasedTimer
@export var _time_label: Label
@export var _slider: HSlider

var current_formation_id: int = -1

func _ready():
	_tick_timer.wait_time = wait_time

func _playback_value_changed(value: float) -> void:
	_update_formation(value)

func _on_color_rect_2_data_updated() -> void:
	_update_formation(timeline_tray.get_current_value())

func _update_formation(value):
	# check if formation has changed
	# IF formatin has changed, emit signal with new formation id 
	# else do nothing
	if timeline_tray.marker_cues.size() == 0:
		current_formation_id = -1
		display_formation.emit(current_formation_id)
		return
	
	var target_idx = timeline_tray.marker_cues.find_custom(func(a): return value < a[0])
	var new_id: int = -1
	match(target_idx):
		0:
			pass
		-1:
			new_id = timeline_tray.marker_cues[-1][1]
		_:
			new_id = timeline_tray.marker_cues[target_idx - 1][1]
	if current_formation_id != new_id:
		current_formation_id = new_id
		display_formation.emit(current_formation_id)


func _on_play_pause_button_toggled(toggled_on: bool) -> void:
	if toggled_on:
		_tick_timer.start()
	else:
		_tick_timer.stop()

func _on_stop_button_pressed() -> void:
	_tick_timer.stop()
	_tick_timer.reset()
	_play_pause_button.set_pressed_no_signal(false)


func _on_tick_based_timer_time_changed(time: float) -> void:
	var minutes = int(time/60)
	var seconds = time - minutes
	_time_label.text = "%02d:%05.02f" % [minutes, seconds]
	_slider.value = time

func _on_tick_based_timer_timeout() -> void:
	_play_pause_button.set_pressed_no_signal(false)

class_name FormationTimeline
extends Control

signal display_formation(id: int)

@export var _timeline_tray: TimelineTray
@export var timeline_duration: float = 10:
	set(value):
		timeline_duration = value
		_timeline_tray.timeline_duration = value
		_tick_timer.wait_time = value

@export var _play_pause_button: Button
@export var _tick_timer: TickBasedTimer
@export var _time_label: Label
@export var _playback_cursor: PlaybackCursor

var current_formation_id: int = -1
var _is_playing_before_drag: bool

func save_data() -> TimelineData:
	var data: TimelineData = TimelineData.new(timeline_duration, _timeline_tray.marker_cues)
	return data

func load_data(data: TimelineData):
	timeline_duration = data.duration
	_timeline_tray.set_markers(data.markers)

func _ready():
	_is_playing_before_drag = false
	_timeline_tray.timeline_duration = timeline_duration
	_tick_timer.wait_time = timeline_duration

func _playback_value_changed(value: float) -> void:
	if _playback_cursor.is_dragging:
		_tick_timer.set_time(value)
	_update_formation(value)

func _on_timeline_tray_data_updated() -> void:
	_update_formation(_timeline_tray.get_current_value())

func _update_formation(value):
	# check if formation has changed
	# IF formatin has changed, emit signal with new formation id 
	# else do nothing
	if _timeline_tray.marker_cues.size() == 0:
		current_formation_id = -1
		display_formation.emit(current_formation_id)
		return
	
	var target_idx = _timeline_tray.marker_cues.find_custom(func(a): return value < a[0])
	var new_id: int = -1
	match(target_idx):
		0:
			pass
		-1:
			new_id = _timeline_tray.marker_cues[-1][1]
		_:
			new_id = _timeline_tray.marker_cues[target_idx - 1][1]
	if current_formation_id != new_id:
		current_formation_id = new_id
		display_formation.emit(current_formation_id)


func _on_play_pause_button_toggled(toggled_on: bool) -> void:
	if toggled_on:
		display_formation.emit(current_formation_id)
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
	
	if not _playback_cursor.is_dragging:
		_playback_cursor.set_value(time)

func _on_tick_based_timer_timeout() -> void:
	_play_pause_button.set_pressed_no_signal(false)

# There are two things that will be controlling time, the timer and playback cursor
# They are both connected, when the timer is running, the cursor is moved by it
# when the cursor is modified, the timer should reflect that.

# Right now, when the timer time changes, the slider gets modified


func _on_h_slider_drag_ended(_value_changed: bool) -> void:
	if _is_playing_before_drag:
		_tick_timer.start()

func _on_h_slider_drag_started() -> void:
	_is_playing_before_drag = _tick_timer._is_running
	_tick_timer.stop()

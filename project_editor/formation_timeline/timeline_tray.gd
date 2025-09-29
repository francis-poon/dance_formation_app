class_name TimelineTray
extends Control

signal data_updated

@export var timeline_duration: float = 10:
	set(value):
		timeline_duration = value
		_playback_cursor.max_value = timeline_duration
		_update_size()

@export var _holder: Node
@export var _playback_cursor: Control

var current_pixels_per_second: float
var minimum_pixels_per_second: float = 11
var marker_cues: Array

func _ready():
	_playback_cursor.max_value = timeline_duration
	_update_size()
	marker_cues = []

func set_markers(markers: Array):
	var formation_manager: FormationManager = get_tree().get_first_node_in_group("formation_manager")
	
	marker_cues = markers
	marker_cues.sort_custom(func(a, b): return a[0] < b[0])
	for child in _holder.get_children():
		child.queue_free()
	for marker in marker_cues:
		var formation: DanceFormation = formation_manager.get_formation(marker[1])
		var timeline_object: FormationTimelineObject = FormationTimelineObject.new()
		timeline_object.set_data(formation.data.id, formation.get_preview())
		
		var target_scale: float = 0.5 * size.y / timeline_object.size.y
		timeline_object.scale = Vector2(target_scale, target_scale)
		_holder.add_child(timeline_object)
		timeline_object.position = Vector2(_time_to_position(marker[0]), size.y / 2 - timeline_object.size.y * timeline_object.scale.y / 2)
	data_updated.emit()

func get_current_value():
	return _playback_cursor.value

func _can_drop_data(_at_position: Vector2, data: Variant) -> bool:
	return data is FormationTimelineObject

func _drop_data(_at_position: Vector2, data: Variant) -> void:
	data = data as FormationTimelineObject
	var target_scale: float = 0.5 * size.y / data.size.y
	data.scale = Vector2(target_scale, target_scale)
	_holder.add_child(data)
	data.position = Vector2(_at_position.x, size.y / 2 - data.size.y * data.scale.y / 2)
	_update_data()

func _update_data():
	marker_cues = []
	for child in _holder.get_children():
		child = child as FormationTimelineObject
		marker_cues.append([_position_to_time(child.position.x), child.formation_id])
	marker_cues.sort_custom(func(a, b): return a[0] < b[0])
	data_updated.emit()

func _update_size():
	# Updates size so that if the duration exceeds the the minimum pixels per
	# second, the size is increaesd to fit the duration
	# scale is pixels per second so size.x / timeline_duration
	await get_tree().process_frame
	current_pixels_per_second = size.x / timeline_duration
	if current_pixels_per_second < minimum_pixels_per_second:
		current_pixels_per_second = minimum_pixels_per_second
		custom_minimum_size.x = minimum_pixels_per_second * timeline_duration
	pass

func _position_to_time(x_pos: float) -> float:
	if current_pixels_per_second == 0:
		return -1
	return x_pos / current_pixels_per_second

func _time_to_position(time: float) -> float:
	if current_pixels_per_second == 0:
		return -1
	return time * current_pixels_per_second

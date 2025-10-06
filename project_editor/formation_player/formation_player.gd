class_name FormationPlayer
extends Control

@export var formation_display: FormationDisplay
@export var _formation_timeline: FormationTimeline

func save_data() -> TimelineData:
	return _formation_timeline.save_data()

func load_data(data: TimelineData):
	_formation_timeline.load_data(data)

func get_timeline_data():
	pass

func load_timeline_data(timeline_data: TimelineData):
	_formation_timeline.load_timeline_data(timeline_data)


func _on_formation_timeline_display_formation(id: int) -> void:
	if id == -1:
		formation_display.clear_display()
	else:
		formation_display.display_formation(id)

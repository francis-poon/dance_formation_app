class_name ProjectData
extends Resource

@export var id: int
@export var name: String
@export var formation_data: DanceFormationCollection
@export var timeline_data: TimelineData

func _init(p_id: int = -1, p_name: String = "Untitled Project",
p_formation_data: DanceFormationCollection = DanceFormationCollection.new(),
p_timeline_data: TimelineData = TimelineData.new()):
	id = p_id
	if id == -1:
		id = randi()
	name = p_name
	formation_data = p_formation_data
	timeline_data = p_timeline_data

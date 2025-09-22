class_name ProjectData
extends Resource

@export var id: int
@export var name: String
@export var formation_data: int
@export var timeline_data: int

func _init(p_id: int = -1, p_name: String = "", p_formation_data: int = -1, p_timeline_data: int = -1):
	id = p_id
	name = p_name
	formation_data = p_formation_data
	timeline_data = p_timeline_data

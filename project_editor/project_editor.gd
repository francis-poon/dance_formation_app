class_name ProjectEditor
extends Control

@export var _formation_player: FormationPlayer

var _formation_manager: FormationManager

var project_id: int
var project_name: String
var formation_data: FormationManagerData
var timeline_data: TimelineData

func _ready():
	_formation_manager = get_tree().get_first_node_in_group("formation_manager")

func save_data() -> ProjectData:
	var formation_data: FormationManagerData = _formation_manager.save_data()
	var timeline_data: TimelineData = _formation_player.save_data()
	
	var project_data: ProjectData = ProjectData.new(
		project_id,
		project_name,
		formation_data,
		timeline_data
	)
	return project_data

func load_data(data: ProjectData):
	project_id = data.id
	project_name = data.name
	_formation_manager.load_data(data.formation_data)
	_formation_player.load_data(data.timeline_data)

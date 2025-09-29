class_name ProjectEditor
extends Control

@export var _formation_player: FormationPlayer

var _formation_manager: FormationManager
var project_data: ProjectData

func _ready():
	project_data = ProjectData.new()
	_formation_manager = get_tree().get_first_node_in_group("formation_manager")

func load_project_data(p_project_data: ProjectData):
	project_data = p_project_data
	_formation_manager.load_data(project_data.formation_data)
	_formation_player.load_project(project_data.timeline_data)
	# have FormationManager load the formation data and then 
	pass

func get_project_data():
	project_data.formation_data = _formation_manager.get_save_data()
	project_data.timeline_data = _formation_manager.get_timeline_data()
	# What do i need to do here?
	# I need to pull the timeline data and formation data and compile it into
	# the ProjectData and return it?
	return project_data

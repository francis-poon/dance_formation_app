class_name ProjectSelector
extends Control

signal open_project(project_id: int)

var _project_manager: ProjectManager

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_project_manager = get_tree().get_first_node_in_group("project_manager")
	_project_manager.new_data_loaded.connect(_on_project_manager_new_data_loaded)
	# for testing
	# listen to when project manager has loaded data
	# "add" new project
	# listen for project manager updated
	# "select" new project
	# so that means project manager has to have two signals, new_data_loaded and updated
	# terrible names, but we'll work with that for now
	# new_data_loaded is for when project manager data is loaded into it from the resource file
	# updated it for when changes to its data are made, but who will listen to this?
	# asside from testing, i don't think anything needs to listen to this
	# oh wait nvm project selector needs to update everytime an update happens since it needs to
	# list all the projects available
	pass # Replace with function body.

func _on_new_project():
	_project_manager.new_project()

func _on_project_selected(project_id: int):
	open_project.emit(project_id)

func _on_project_manager_new_data_loaded():
	#_on_new_project()
	_on_project_selected(_project_manager.data.project_dict.keys()[0])
	

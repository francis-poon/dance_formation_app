class_name ProjectManager
extends Node

# This will have a project manager data and will be called to update the data
# or load it
@export var data: ProjectManagerData

func get_project_resource(project_id: int):
	pass

func update_project(project_data: ProjectData):
	pass

func load_data(resource_path: String):
	pass

class_name ProjectManager
extends Node

# This will have a project manager data and will be called to update the data
# or load it
@export var data: ProjectManagerData

func get_project_resource(project_id: int) -> ProjectData:
	print("Warning ProjectManager.get_project_resource not implemented")
	return ProjectData.new()

func update_project(project_data: ProjectData):
	print("Warning ProjectManager.update_project not implemented")
	pass

func load_data(resource_path: String):
	if not FileAccess.file_exists(resource_path):
		print(("Project Manager failed to find \"{0}\".\n" +
		"Loading fresh instance of project manager data.").format([resource_path]))
		data = ProjectManagerData.new()
		return
	data = ResourceLoader.load(resource_path)
	if not data or data is not ProjectManagerData:
		print(("Project Manager failed to load \"{0}\".\n" +
		"Loading fresh instance of project manager data").format([resource_path]))
		data = ProjectManagerData.new()
		return
	pass

func get_save_data() -> ProjectManagerData:
	if not data:
		return ProjectManagerData.new()
	return data

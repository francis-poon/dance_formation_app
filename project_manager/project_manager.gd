class_name ProjectManager
extends Node

signal new_data_loaded
signal updated

# This will have a project manager data and will be called to update the data
# or load it
@export var data: ProjectManagerData

func new_project():
	var new_project: ProjectData = ProjectData.new()
	var new_project_ref: ProjectReference = ProjectReference.new(new_project.id, new_project.name)
	ResourceSaver.save(new_project_ref, new_project_ref.project_resource_path)
	data.project_dict[new_project_ref.id] = new_project_ref
	updated.emit()

func get_project_resource(project_id: int) -> ProjectData:
	print("Warning ProjectManager.get_project_resource not implemented")
	return ProjectData.new()

func get_project_save_path(project_id: int) -> String:
	print("Warning ProjectManager.get_project_save_path not implemented")
	return ""

func update_project(project_data: ProjectData):
	print("Warning ProjectManager.update_project not implemented")
	pass

func load_data(resource_path: String):
	if not FileAccess.file_exists(resource_path):
		print(("Project Manager failed to find \"{0}\".\n" +
		"Loading fresh instance of project manager data.").format([resource_path]))
		data = ProjectManagerData.new()
		new_data_loaded.emit()
		return
	data = ResourceLoader.load(resource_path)
	if not data or data is not ProjectManagerData:
		print(("Project Manager failed to load \"{0}\".\n" +
		"Loading fresh instance of project manager data").format([resource_path]))
		data = ProjectManagerData.new()
	new_data_loaded.emit()

func get_save_data() -> ProjectManagerData:
	if not data:
		return ProjectManagerData.new()
	return data

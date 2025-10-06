class_name ProjectManager
extends Node

signal new_data_loaded
signal updated

# This will have a project manager data and will be called to update the data
# or load it
var project_ref_dict: Dictionary = {}


func new_project():
	var new_project: ProjectData = ProjectData.new()
	var new_project_ref: ProjectReference = ProjectReference.new(new_project.id, new_project.name)
	ResourceSaver.save(new_project, new_project_ref.project_resource_path)
	project_ref_dict[new_project_ref.id] = new_project_ref
	updated.emit()

func get_project_resource(project_id: int) -> ProjectData:
	if project_ref_dict.has(project_id):
		var project_reference: ProjectReference = project_ref_dict[project_id]
		var project_data: ProjectData = ResourceLoader.load(project_reference.project_resource_path)
		if project_data:
			return project_data
	#print("Warning ProjectManager.get_project_resource not implemented")
	return ProjectData.new()

func get_project_save_path(project_id: int) -> String:
	if project_ref_dict.has(project_id):
		var project_reference: ProjectReference = project_ref_dict[project_id]
		return project_reference.project_resource_path
	return ""

func update_project(project_data: ProjectData):
	print("Warning ProjectManager.update_project not implemented")
	pass


func save_data() -> ProjectManagerData:
	var project_refs: Array[ProjectReference] = []
	project_refs.assign(project_ref_dict.values())
	
	return ProjectManagerData.new(project_refs)

func load_data(data: ProjectManagerData):
	project_ref_dict = {}
	if data:
		for project_ref in data.project_refs:
			project_ref_dict[project_ref.id] = project_ref
	new_data_loaded.emit()

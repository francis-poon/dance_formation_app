class_name ProjectManager
extends Node

signal new_data_loaded
signal updated(project_id: int, mode: UpdateMode)

enum UpdateMode {
	MODIFY,
	ADD,
	DELETE
}

# This will have a project manager data and will be called to update the data
# or load it
var project_ref_dict: Dictionary = {}

# ------------------------------------------------------------------------------
## Save/Load system
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

# ------------------------------------------------------------------------------
## Project add, modify, and delete
func new_project(project_name: String = ""):
	var new_project: ProjectData = ProjectData.new()
	if project_name != "":
		new_project.name = project_name
	add_project(new_project)
	ResourceSaver.save(new_project, project_ref_dict[new_project.id].project_resource_path)

func add_project(project_data: ProjectData):
	var new_project_ref: ProjectReference = ProjectReference.new(project_data.id, project_data.name)
	project_ref_dict[new_project_ref.id] = new_project_ref
	updated.emit(new_project_ref.id, UpdateMode.ADD)

func update_project(project_data: ProjectData):
	print("Warning ProjectManager.update_project not implemented")
	updated.emit(project_data.id, UpdateMode.MODIFY)
	pass

func rename_project(project_id: int, project_name: String):
	if project_ref_dict.has(project_id):
		var project_ref: ProjectReference = project_ref_dict[project_id]
		project_ref.name = project_name
		updated.emit(project_id, UpdateMode.MODIFY)

func delete_project(project_id: int):
	if project_ref_dict.has(project_id):
		var project_ref: ProjectReference = project_ref_dict[project_id]
		DirAccess.remove_absolute(project_ref.project_resource_path)
		project_ref_dict.erase(project_id)
		updated.emit(project_id, UpdateMode.DELETE)

# ------------------------------------------------------------------------------
## Project data getters
func get_project_ids() -> Array[int]:
	var project_ids: Array[int] = []
	project_ids.assign(project_ref_dict.keys())
	return project_ids

func has_project(project_id: int) -> bool:
	return project_ref_dict.has(project_id)

func get_project_name(project_id: int) -> String:
	if not project_ref_dict.has(project_id):
		return ""
	
	var project_reference: ProjectReference = project_ref_dict[project_id]
	return project_reference.name

func get_project_resource(project_id: int) -> ProjectData:
	# TODO: Okay this needs to be changed so that if the project save file doesn't
	# exist, use the project ref to create a new project data and return that
	if project_ref_dict.has(project_id):
		var project_reference: ProjectReference = project_ref_dict[project_id]
		var project_data: ProjectData = ResourceLoader.load(project_reference.project_resource_path)
		if project_data:
			return project_data
		else:
			project_data = ProjectData.new(project_id)
	#print("Warning ProjectManager.get_project_resource not implemented")
	return ProjectData.new(project_id)

func get_project_save_path(project_id: int) -> String:
	if project_ref_dict.has(project_id):
		var project_reference: ProjectReference = project_ref_dict[project_id]
		return project_reference.project_resource_path
	return ""

# ------------------------------------------------------------------------------

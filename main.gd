extends Control

@export var _project_selector: Control
@export var _project_editor: ProjectEditor

var _project_manager: ProjectManager

var _save_dir: String
var _project_dir: String
var _project_manager_res_path: String

# 09-22-2025 happy birthday francis
# here's to 26
# here's to regaining my spark in life

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Globals.developer_mode:
		_save_dir = "res://saves/"
	else:
		_save_dir = "user://saves/"
	_project_dir = _save_dir + "projects/"
	_project_manager_res_path = _save_dir + "project_manager_data.tres"
	
	_project_manager = get_tree().get_first_node_in_group("project_manager")
	if _project_manager == null:
		print("Failed to load project manager")
	_load_data()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("save"):
		print("Save")
		# Get project save data, update the manager with project reference
		# save the project data to /saves/projects/<project_id>.tres
		# save the project manager to saves/project_manager_data.tres
		ResourceSaver.save(_project_manager.get_save_data(), _project_manager_res_path)
		
		var project_data: ProjectData = _project_editor.get_project_data()
		var project_save_path: String = _project_manager.get_project_save_path(project_data.id)
		ResourceSaver.save(_project_editor.get_project_data(), project_save_path)


func _load_data():
	_project_manager.load_data(_project_manager_res_path)

func _on_project_selected(project_id: int):
	_project_selector.hide()
	_project_editor.load_project_data(_project_manager.get_project_resource(project_id))

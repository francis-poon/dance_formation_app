extends Control

@export var _project_selector: Control
@export var _project_editor: Control

var _project_manager: ProjectManager

# 09-22-2025 happy birthday francis
# here's to 26
# here's to regaining my spark in life

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
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
		_project_manager.get_save_data()
		#_project_editor.get_save_data()

func _load_data():
	var project_manager_res_path: String
	if Globals.developer_mode:
		print("Loading data in developer mode")
		project_manager_res_path = "res://saves/project_manager_data.tres"
	else:
		print("Loading Data")
		project_manager_res_path = "user://saves/project_manager_data.tres"
	_project_manager.load_data(project_manager_res_path)

func _on_project_selected(project_id: int):
	_project_editor.load_project_data(_project_manager.get_project_resource(project_id))

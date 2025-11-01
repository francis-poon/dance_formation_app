class_name ProjectSelector
extends Control

signal open_project(project_id: int)

@export var _project_selection_holder: Control
@export var _project_interact_buttons: Control

@export var _project_naming_prompt: ProjectNamingPrompt
@export var _create_project_prompt: CreateProjectPrompt
@export var _project_select_button_scene: PackedScene

var _project_manager: ProjectManager

var _selected_project_button: ProjectSelectButton
var _project_selection_button_dict: Dictionary = {}

# GUI Elements to add, modify, and delete projects
# Each of these will send a request to the project manager
# Project manager will do these things and then send out an
# update signal. Project selector will receive this update signal
# and update the selection buttons to reflect the project manager state

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_project_manager = get_tree().get_first_node_in_group("project_manager")
	_project_manager.new_data_loaded.connect(_on_project_manager_new_data_loaded)
	_project_manager.updated.connect(_on_project_manager_update)
	
	for button in _project_interact_buttons.get_children():
		if button is Button:
			button.disabled = true

# ------------------------------------------------------------------------------
## Internal project button updating functions to reflect state of project manager

func _update_project_select_button(project_id: int):
	var project_name: String = _project_manager.get_project_name(project_id)
	_project_selection_button_dict[project_id].load_data(project_id, project_name)

func _add_project_select_button(project_id: int):
	var project_selection_button: ProjectSelectButton = _project_select_button_scene.instantiate()
	var project_name: String = _project_manager.get_project_name(project_id)
	project_selection_button.load_data(project_id, project_name)
	project_selection_button.select_project.connect(_on_project_selected)
	_project_selection_button_dict[project_id] = project_selection_button
	_project_selection_holder.add_child(project_selection_button)

func _delete_project_select_button(project_id: int):
	if _project_selection_button_dict.has(project_id):
		_project_selection_button_dict[project_id].queue_free()
		_project_selection_button_dict.erase(project_id)

# ------------------------------------------------------------------------------
## Handlers for when GUI request project manager to add, modify, or delete
## a project
 
func _on_new_project_button_pressed():
	# Show new project screen with project name later on
	_create_project_prompt.open()

func _on_delete_project_button_pressed():
	pass

func _on_modify_project_button_pressed():
	pass
# ------------------------------------------------------------------------------


func _on_project_selected(project_button: ProjectSelectButton):
	_selected_project_button = project_button
	for button in _project_interact_buttons.get_children():
		if button is Button:
			button.disabled = false

func _on_edit_project_pressed():
	if _selected_project_button == null:
		return
	open_project.emit(_selected_project_button.project_id)

func _on_delete_project_pressed():
	if _selected_project_button == null:
		return
	_project_manager.delete_project(_selected_project_button.project_id)

func _on_rename_project_pressed():
	if _selected_project_button:
		_project_naming_prompt.open(_selected_project_button.project_name)

func _on_project_manager_new_data_loaded():
	_project_selection_button_dict = {}
	_selected_project_button = null
	for child in _project_selection_holder.get_children():
		child.queue_free()
	for project_id in _project_manager.get_project_ids():
		_add_project_select_button(project_id)
	#_on_new_project()
	#_on_project_selected(_project_manager.project_ref_dict.keys()[0])
	
func _on_project_manager_update(project_id: int, mode: ProjectManager.UpdateMode):
	# project update can be a new project, modify, or delete
	match mode:
		ProjectManager.UpdateMode.MODIFY:
			_update_project_select_button(project_id)
		ProjectManager.UpdateMode.ADD:
			_add_project_select_button(project_id)
		ProjectManager.UpdateMode.DELETE:
			_delete_project_select_button(project_id)


func _on_project_naming_prompt_name_project(project_name: String) -> void:
	if _selected_project_button:
		var project_id = _selected_project_button.project_id
		_project_manager.rename_project(project_id, project_name)
		


func _on_create_project_prompt_cancel() -> void:
	pass # Replace with function body.


func _on_create_project_prompt_create_project(project_name: String) -> void:
	_project_manager.new_project(project_name)

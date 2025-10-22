extends Control

# make it first
# make it first
# make it first
# just make it
# make it exist
# make it work
# make it first
# make it be real
# get it out of your head
# get it to people
# get something that works
# get anything works 
# it doesn't have to be good
# it doesn't have to work well
# it doesn't even have to work all the time
# it doesn't even have to work correctly
# get something that does something, anything at all
# we can make it better from there
# that's the part youre good at
# making things work better
# don't worry about that right now
# don't worry about it being good right now
# there's no doubt that you can make it good
# you will make it good
# just make it bad right now
# please im begging you francis make it at all
# don't keep letting everything you are
# stop you
# you aren't strong enough to stop yourself
# from doing all the things you want to do
# so go do them

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
	_save_dir = Globals.get_save_dir_root()
	_project_dir = Globals.get_project_save_dir()
	if not DirAccess.dir_exists_absolute(_save_dir):
		DirAccess.make_dir_recursive_absolute(_save_dir)
	if not DirAccess.dir_exists_absolute(_project_dir):
		DirAccess.make_dir_recursive_absolute(_project_dir)
	
	_project_manager_res_path = _save_dir + "project_manager_data.tres"
	
	_project_manager = get_tree().get_first_node_in_group("project_manager")
	if _project_manager == null:
		print("Failed to load project manager")
	
	_load_data()

func _input(event: InputEvent) -> void:
	# TODO: This needs to only activate when in project editing mode
	# Do this with a state machine or just a boolean?
	if event.is_action_pressed("save"):
		print("Save")
		# Get project save data, update the manager with project reference
		# save the project data to /saves/projects/<project_id>.tres
		# save the project manager to saves/project_manager_data.tres
		var project_data: ProjectData = _project_editor.save_data()
		if not _project_manager.has_project(project_data.id):
			_project_manager.add_project(project_data)
		
		var project_save_path: String = _project_manager.get_project_save_path(project_data.id)
		ResourceSaver.save(project_data, project_save_path)


func _load_data():
	var project_manager_data: ProjectManagerData = ProjectManagerData.new()
	if FileAccess.file_exists(_project_manager_res_path):
		var data = ResourceLoader.load(_project_manager_res_path)
		if data and data is ProjectManagerData:
			project_manager_data = data
	_project_manager.load_data(project_manager_data)


func _on_project_selector_open_project(project_id: int) -> void:
	_project_selector.hide()
	_project_editor.show()
	await get_tree().process_frame
	_project_editor.load_data(_project_manager.get_project_resource(project_id))


func _on_project_manager_updated(project_id: int, mode: ProjectManager.UpdateMode) -> void:
	ResourceSaver.save(_project_manager.save_data(), _project_manager_res_path)

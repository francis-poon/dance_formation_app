class_name DanceFormation
extends Control

signal formation_changed(dancer_positions: Array[Vector2])

@export var _dancer_scene: PackedScene
@export var stage: Control

#@export var stage_size: Vector2 = Vector2(400, 500):
	#set(value):
		#stage_size = value
		#stage.size = stage_size
@export var _preview_scene: PackedScene

var id: int = randi()
var dancer_positions: Array[Vector2] = []

func save_data() -> DanceFormationData:
	return DanceFormationData.new(id, dancer_positions)

func load_data(data: DanceFormationData):
	id = data.id
	dancer_positions = []
	for child in stage.get_children():
		child.queue_free()
	
	for dancer_pos in data.dancer_positions:
		add_dancer_local_pos(dancer_pos)

func request_rand_id() -> void:
	id = randi()

func add_dancer_local_pos(local_pos: Vector2):
	var new_dancer: Dancer = _dancer_scene.instantiate()
	new_dancer.id = stage.get_children().size()
	stage.add_child(new_dancer)
	new_dancer.position = local_pos# - stage.position
	new_dancer.dancer_moved.connect(_on_dancer_moved)
	new_dancer.dancer_deleted.connect(_on_dancer_deleted)
	dancer_positions.append(new_dancer.position)
	formation_changed.emit(dancer_positions)

func add_dancer_global_pos(global_pos: Vector2):
	var new_dancer: Dancer = _dancer_scene.instantiate()
	new_dancer.id = stage.get_children().size()
	stage.add_child(new_dancer)
	new_dancer.global_position = global_pos
	new_dancer.dancer_moved.connect(_on_dancer_moved)
	new_dancer.dancer_deleted.connect(_on_dancer_deleted)
	dancer_positions.append(new_dancer.position)
	formation_changed.emit(dancer_positions)

func get_preview() -> Control:
	var preview: DanceFormationPreview = _preview_scene.instantiate()
	preview.set_preview(id, dancer_positions, stage.size)
	formation_changed.connect(preview._on_formation_changed)
	return preview

func _on_dancer_moved(dancer_id: int, p_position: Vector2):
	dancer_positions[dancer_id] = p_position
	formation_changed.emit(dancer_positions)

func _on_dancer_deleted(dancer_id: int):
	dancer_positions.remove_at(dancer_id)
	for dancer in stage.get_children():
		dancer = dancer as Dancer
		if dancer.id > dancer_id:
			dancer.id -= 1
	formation_changed.emit(dancer_positions)


#func _on_formation_changed(dancer_positions: Array[Vector2]) -> void:
	#var manager: FormationManager = get_tree().get_first_node_in_group("formation_manager")
	#print("Formation ID: {0}\nSelf Instance ID:{1}\nManager Instance ID: {2}".format([
		#id, self.get_instance_id(), manager.get_formation(id).get_instance_id()
	#]))

class_name FormationManager
extends Node

signal new_data_loaded

@export var formation_scene: PackedScene

var data: DanceFormationCollection

func _ready():
	print("TODO: Make FormationManager check if there are other instances.")
	data = DanceFormationCollection.new()

#func _gui_input(event: InputEvent) -> void:
	#if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT \
	 #and event.is_pressed() and current_formation:
		#current_formation.add_dancer(event.position)


func get_formation(id: int) -> DanceFormation:
	if data.id_formation_dict.has(id):
		return data.id_formation_dict[id]
	return null

func get_new_formation() -> DanceFormation:
	var new_formation: DanceFormation = formation_scene.instantiate()
	while data.id_formation_dict.has(new_formation.data.id):
		new_formation.request_rand_id()
	data.id_formation_dict[new_formation.data.id] = new_formation
	return new_formation

func has_formation(id: int) -> bool:
	return data.id_formation_dict.has(id)

func add_formation(formation: DanceFormation) -> void:
	while data.id_formation_dict.has(formation.data.id):
		formation.request_rand_id()
	data.id_formation_dict[formation.data.id] = formation

func get_save_data():
	return data.seiralize()

func load_data(formation_data: DanceFormationCollection):
	data = formation_data
	if not data or data is not DanceFormationCollection:
		data = DanceFormationCollection.new()
		new_data_loaded.emit()
		return
	data.deserialize()
	new_data_loaded.emit()
